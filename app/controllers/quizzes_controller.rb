class QuizzesController < ApplicationController
  def show
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @quiz_choices = @quiz.quiz_choices
    handle_level_up
  end

  def random_quiz
    next_quiz = Quiz.next_quiz_for_user(current_user)
    redirect_to quiz_path(next_quiz)
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
