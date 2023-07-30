class QuizChoice < ApplicationRecord
  include Boldable

  belongs_to :quiz
  has_many :user_quiz_histories, dependent: :destroy
  validates :furigana, presence: true
  validates :is_correct, inclusion: { in: [true, false] }
end
