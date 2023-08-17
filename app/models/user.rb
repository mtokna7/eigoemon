class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_quiz_histories, dependent: :destroy

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def record_quiz_history(quiz_choice)
    word_id = quiz_choice.quiz.word_id
    is_correct = quiz_choice.is_correct
    quiz_history = user_quiz_histories.create!(
      word_id: word_id, 
      quiz_choice: quiz_choice, 
      is_correct: is_correct
    )
    check_level_up
    quiz_history
  end

  private

  def check_level_up
    correct_count = user_quiz_histories.where(is_correct: true).count

    case level
    when 0
      if correct_count == 2
        increase_level
      end
    when 1
      if correct_count == 7
        increase_level
      end
    when 2
      if correct_count == 13
        increase_level
      end
    when 3
      if correct_count == 10000000 #本リリース時に修正
        increase_level
      end
    end
  end

  def increase_level
    increment!(:level)
    update!(leveled_up: true)
  end
end