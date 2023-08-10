class QuizzesController < ApplicationController
  def show
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @quiz_choices = @quiz.quiz_choices
    
    if current_user.leveled_up || current_user.level == 0
      @level_up = true
      @conversations = Conversation.where(level: current_user.level).order(:order)
      current_user.update(leveled_up: false)  # モーダル表示後にフラグをリセット
    else
      @level_up = false
    end
  end  

  def index
    @quizzes = Quiz.all
  end
end