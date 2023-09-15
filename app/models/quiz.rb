class Quiz < ApplicationRecord
  belongs_to :word
  has_many :quiz_choices, dependent: :destroy

  def correct_rate(user)
    total = UserQuizHistory.where(user: user, word_id: self.word_id).count
    correct = UserQuizHistory.where(user: user, word_id: self.word_id, is_correct: true).count
    return 100.0 if total.zero?

    ((correct.to_f / total) * 100).ceil
  end

  def self.get_review_quiz_for_user(user)
    low_rate_quizzes = Quiz.all.select { |quiz| quiz.correct_rate(user) < 60.0 }
    sorted_by_count = low_rate_quizzes.sort_by { |quiz| UserQuizHistory.where(user: user, word_id: quiz.word_id).count }
    sorted_by_count.first
  end
end
