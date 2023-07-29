class Word < ApplicationRecord
  has_one :quiz, dependent: :destroy
  has_many :user_quiz_histories, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :programming_explanation, presence: true
  validates :english_explanation, presence: true
  validates :furigana, presence: true

  after_create :create_quiz

  private

  def create_quiz
    self.create_quiz!
  end
end