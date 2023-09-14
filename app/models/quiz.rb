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
    incorrect_histories = UserQuizHistory.where(user: user, is_correct: false).order(:created_at)
    incorrect_word_ids = incorrect_histories.pluck(:word_id).uniq
    oldest_incorrect_word_id = incorrect_word_ids.first
    Quiz.find_by(word_id: oldest_incorrect_word_id)
  end
end
