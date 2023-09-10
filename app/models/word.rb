class Word < ApplicationRecord
  include Boldable

  has_one :quiz, dependent: :destroy
  has_many :user_quiz_histories, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  validates :name, presence: true, uniqueness: true
  validates :programming_explanation, presence: true
  validates :english_explanation, presence: true
  validates :furigana, presence: true

  after_create :create_quiz

  def favorited_by?(user)
    favorite_users.include?(user)
  end

  private

  def create_quiz
    self.create_quiz!
  end
end
