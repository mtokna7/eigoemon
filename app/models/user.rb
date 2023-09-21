class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_quiz_histories, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_create :set_last_sign_in_at

  LEVEL_UP_THRESHOLDS = 4
  MAX_DAILY_LEVEL_UP = 2
  MAX_LEVEL = 10

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

  def check_level_up
    if last_leveled_up_at && last_leveled_up_at.to_date != Date.current
      update!(daily_level_up_count: 0, last_leveled_up_at: nil)
    end

    correct_count_today = user_quiz_histories.where(is_correct: true, created_at: Date.current.all_day).count

    return unless correct_count_today.positive?

    remainder_today = correct_count_today % LEVEL_UP_THRESHOLDS

    return unless remainder_today.zero? && daily_level_up_count < MAX_DAILY_LEVEL_UP

    increase_level
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
