class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_quiz_histories, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_create :set_last_sign_in_at

  MAX_DAILY_LEVEL_UP = 2
  MAX_LEVEL = 10
  LEVEL_UP_THRESHOLD_FOR_LEVEL_0 = 1
  LEVEL_UP_THRESHOLD_FOR_OTHERS = 4

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

  def level_up_threshold
    case level
    when 0
      LEVEL_UP_THRESHOLD_FOR_LEVEL_0
    else
      LEVEL_UP_THRESHOLD_FOR_OTHERS
    end
  end

  def check_level_up
    reset_daily_level_up_count_if_needed

    correct_count_today = user_quiz_histories.where(is_correct: true, created_at: Date.current.all_day).count

    return if level.zero? && correct_count_today.zero?

    return unless (correct_count_today % level_up_threshold).zero? && daily_level_up_count < MAX_DAILY_LEVEL_UP

    increase_level
  end

  def reset_daily_level_up_count_if_needed
    return unless last_leveled_up_at && last_leveled_up_at.to_date != Date.current

    update!(daily_level_up_count: 0, last_leveled_up_at: nil)
  end

  # rubocop:disable Rails/SkipsModelValidations
  def increase_level
    return if level >= MAX_LEVEL

    increment!(:level)
    increment!(:daily_level_up_count)
    update!(last_leveled_up_at: Time.current, leveled_up: true)
  end
  # rubocop:enable Rails/SkipsModelValidations

  def set_last_sign_in_at
    self.last_sign_in_at = Time.current
  end
end
