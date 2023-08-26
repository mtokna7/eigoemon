class QuizzesController < ApplicationController
  def show
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @quiz_choices = @quiz.quiz_choices
    handle_level_up
  end

  private

  def handle_level_up
    if level_up_conditions_met?
      @level_up = true
      @conversations = Conversation.where(level: current_user.level).order(:order)
      reset_flags
    else
      @level_up = false
    end
  end

  def level_up_conditions_met?
    current_user.leveled_up || (current_user.level.zero? && current_user.first_visit)
  end

  def reset_flags
    current_user.update(leveled_up: false, first_visit: false)
  end
end
