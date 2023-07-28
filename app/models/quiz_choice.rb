class QuizChoice < ApplicationRecord
  belongs_to :quiz
  has_many :user_quiz_histories, dependent: :destroy
  validates :furigana, presence: true
  validates :is_correct, inclusion: { in: [true, false] }

  def parts
    if bold_start.nil? || bold_end.nil?
      [furigana, nil, nil]
    else
      [furigana[0...bold_start], furigana[bold_start...bold_end], furigana[bold_end..]]
    end
  end
end