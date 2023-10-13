class Quiz < ApplicationRecord
  belongs_to :word
  has_many :quiz_choices, dependent: :destroy

  LOW_CORRECT_RATE_THRESHOLD = 60.0
  MAX_CORRECT_RATE = 100.0

  def correct_rate(user)
    total = UserQuizHistory.where(user: user, word_id: self.word_id).count
    correct = UserQuizHistory.where(user: user, word_id: self.word_id, is_correct: true).count
    return MAX_CORRECT_RATE if total.zero?

    ((correct.to_f / total) * MAX_CORRECT_RATE).ceil
  end

  def self.get_review_quiz_for_user(user)
    low_rate_quizzes = Quiz.all.select { |quiz| quiz.correct_rate(user) < LOW_CORRECT_RATE_THRESHOLD }
    sorted_by_count = low_rate_quizzes.sort_by { |quiz| UserQuizHistory.where(user: user, word_id: quiz.word_id).count }
    sorted_by_count.first
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
