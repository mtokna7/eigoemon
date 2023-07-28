class UserQuizHistory < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :quiz_choice
  validates :is_correct, inclusion: { in: [true, false] }
end
