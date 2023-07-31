class ExplanationsController < ApplicationController
  def programming
    @word = Word.find(params[:id])
    chosen_quiz_choice = QuizChoice.find(params[:choice_id])
    quiz_id = chosen_quiz_choice.quiz_id
    is_correct = chosen_quiz_choice.is_correct
    UserQuizHistory.create!(
      user: current_user, 
      quiz_id: quiz_id, 
      quiz_choice: chosen_quiz_choice, 
      is_correct: is_correct
    )
    @user_quiz_history = UserQuizHistory.where(user: current_user, quiz_id: quiz_id).last
    increase_user_level if @user_quiz_history.is_correct && current_user.user_quiz_histories.where(is_correct: true).count % 3 == 0
  end

  def english
  end
  
  private
  
  def increase_user_level
    current_user.increment!(:level)
  end
end
