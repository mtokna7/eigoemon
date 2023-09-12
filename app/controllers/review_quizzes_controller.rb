class ReviewQuizzesController < ApplicationController
  def show
    @user = current_user
    low_rate_quizzes = Quiz.all.select { |quiz| quiz.correct_rate(@user) < 60.0 }
    @quiz = low_rate_quizzes.sample
    @quiz_choices = @quiz&.quiz_choices
  end

  def explanation
    @word = Word.find(params[:id])
    chosen_quiz_choice = QuizChoice.find(params[:choice_id])
    @user_quiz_history = current_user.record_quiz_history(chosen_quiz_choice)
  end
end
