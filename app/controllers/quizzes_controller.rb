class QuizzesController < ApplicationController
  def show
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @quiz_choices = @quiz.quiz_choices
    handle_level_up
  end

  def random_quiz
    quiz_answer_counts = Quiz.all.each_with_object({}) do |quiz, hash|
      hash[quiz.id] = current_user.user_quiz_histories.where(word_id: quiz.word_id).count
    end
    min_answered_quiz_ids = quiz_answer_counts.select { |_, count| count == quiz_answer_counts.values.min }.keys
    next_quiz_id = min_answered_quiz_ids.sample

    redirect_to quiz_path(next_quiz_id)
  end

  private

  def handle_level_up
    if level_up_conditions_met?
      execute_level_up
    else
      @level_up = false
    end
  end

  def level_up_conditions_met?
    current_user.leveled_up || (current_user.level.zero? && current_user.first_visit)
  end

  def execute_level_up
    @level_up = true
    @conversations = Conversation.where(level: current_user.level).order(:order)
    reset_flags
  end

  def reset_flags
    current_user.update(leveled_up: false, first_visit: false)
  end
end
