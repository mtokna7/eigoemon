class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_quiz_histories, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_create :set_last_sign_in_at

  def after_database_authentication
    super
    update(last_sign_in_at: Time.current)
  end

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

  # rubocop:disable Style/IfUnlessModifier
  # rubocop:disable Metrics/MethodLength
  def check_level_up
    correct_count = user_quiz_histories.where(is_correct: true).count

    case level
    when 0
      if correct_count == 3
        increase_level
      end
    when 1
      if correct_count == 10_000_000 # 本リリース時に修正 メソッド全体修正後にrubocopの除外を外す
        increase_level
      end
    end
  end
  # rubocop:enable Style/IfUnlessModifier
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Rails/SkipsModelValidations
  def increase_level
    increment!(:level)
    update!(leveled_up: true)
  end
  # rubocop:enable Rails/SkipsModelValidations

  def set_last_sign_in_at
    self.last_sign_in_at = Time.current
  end
end
