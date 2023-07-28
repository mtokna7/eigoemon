class QuizChoice < ApplicationRecord
  belongs_to :quiz
  has_many :user_quiz_histories, dependent: :destroy
  validates :furigana, presence: true
  validates :is_correct, inclusion: { in: [true, false] }

  def bold_range_exists?
    !bold_start.nil? && !bold_end.nil?
  end

  def parts
    if bold_range_exists?
      {first_part: furigana[0...bold_start], bold_part: furigana[bold_start...bold_end], last_part: furigana[bold_end..]}
    else
      {first_part: furigana, bold_part: nil, last_part: nil}
    end
  end
end
