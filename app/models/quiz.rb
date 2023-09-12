class Quiz < ApplicationRecord
  belongs_to :word
  has_many :quiz_choices, dependent: :destroy

  def correct_rate(user)
    total = UserQuizHistory.where(user: user, word_id: self.word_id).count
    correct = UserQuizHistory.where(user: user, word_id: self.word_id, is_correct: true).count
    return 100.0 if total.zero?

    ((correct.to_f / total) * 100).ceil
  end
end
