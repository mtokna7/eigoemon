class Word < ApplicationRecord
  has_one :quiz, dependent: :destroy
  has_many :user_quiz_histories, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :programming_explanation, presence: true
  validates :english_explanation, presence: true
  validates :furigana, presence: true
end
