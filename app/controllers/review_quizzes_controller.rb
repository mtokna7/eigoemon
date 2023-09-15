class ReviewQuizzesController < ApplicationController
  def generate
    @user = current_user
    @quiz = Quiz.get_review_quiz_for_user(@user)
    if @quiz
      redirect_to review_quiz_path(@quiz)
    else
      redirect_to no_quizzes_review_quizzes_path
    end
  end
  
  def show
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @quiz_choices = @quiz.quiz_choices
    handle_level_up
  end

  def explanation
    @word = Word.find(params[:id])
    chosen_quiz_choice = QuizChoice.find(params[:choice_id])
    @user_quiz_history = current_user.record_quiz_history(chosen_quiz_choice)
  end
end
