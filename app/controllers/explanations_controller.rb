class ExplanationsController < ApplicationController
  def programming
    @word = Word.find(params[:id])
    chosen_quiz_choice = QuizChoice.find(params[:choice_id])
    @user_quiz_history = current_user.record_quiz_history(chosen_quiz_choice)
  end

  def english
    @word = Word.find(params[:id])
  end
end
