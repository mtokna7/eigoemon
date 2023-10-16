class Quiz < ApplicationRecord
  belongs_to :word
  has_many :quiz_choices, dependent: :destroy

  SAME_DAY = 0
  AFTER_5_DAYS = 5

  def self.get_review_quiz_for_user(user)
    answered_quizzes = Quiz.joins(quiz_choices: :user_quiz_histories)
                           .where(user_quiz_histories: { user_id: user.id })
                           .distinct

    review_candidate_quizzes = answered_quizzes.select do |quiz|
      latest_history = get_latest_history(user, quiz)
      days_since_last_answer = (Time.zone.today - latest_history.created_at.to_date).to_i

      if latest_history.is_correct?
        evaluate_correct_histories(user, quiz, days_since_last_answer, latest_history)
      else
        days_since_last_answer >= SAME_DAY
      end
    end

    sorted_quizzes = sort_quizzes_by_latest_answer(user, review_candidate_quizzes)
    sorted_quizzes.first
  end

  def self.get_latest_history(user, quiz)
    UserQuizHistory.where(user: user, word_id: quiz.word_id).order(created_at: :desc).first
  end

  def self.evaluate_correct_histories(user, quiz, days_since_last_answer, _latest_history)
    correct_histories = UserQuizHistory.where(user: user, word_id: quiz.word_id, is_correct: true)
                                       .order(created_at: :desc)
    last_incorrect_date = UserQuizHistory.where(user: user, word_id: quiz.word_id, is_correct: false)
                                         .order(created_at: :desc)
                                         .first&.created_at

    consecutive_correct_count = if last_incorrect_date
                                  correct_histories.take_while { |h| h.created_at > last_incorrect_date }.count
                                else
                                  correct_histories.count
                                end

    evaluate_consecutive_correct_count(consecutive_correct_count, days_since_last_answer)
  end

  def self.evaluate_consecutive_correct_count(count, days_since_last_answer)
    case count
    when 1
      days_since_last_answer >= SAME_DAY
    when 2
      days_since_last_answer >= AFTER_5_DAYS
    else
      false
    end
  end

  def self.sort_quizzes_by_latest_answer(user, quizzes)
    quizzes.sort_by do |quiz|
      UserQuizHistory.where(user: user, word_id: quiz.word_id).order(created_at: :desc).first.created_at
    end
  end

  def self.next_quiz_for_user(user)
    unanswered_quizzes = all.reject do |quiz|
      user.user_quiz_histories.exists?(word_id: quiz.word_id)
    end

    return unanswered_quizzes.sample if unanswered_quizzes.any?

    quiz_answer_counts = all.each_with_object({}) do |quiz, hash|
      hash[quiz.id] = user.user_quiz_histories.where(word_id: quiz.word_id).count
    end
    min_answered_quiz_ids = quiz_answer_counts.select { |_, count| count == quiz_answer_counts.values.min }.keys

    oldest_answered_quiz = min_answered_quiz_ids.map do |quiz_id|
      user.user_quiz_histories.where(word_id: quiz_id).order(created_at: :asc).first
    end.compact.min_by(&:created_at)

    oldest_answered_quiz ? find(oldest_answered_quiz.word_id) : find(min_answered_quiz_ids.sample)
  end
end
