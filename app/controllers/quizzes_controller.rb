class QuizzesController < ApplicationController
  def show
    @quiz = Quiz.find(params[:id])
    @quiz_choices = @quiz.quiz_choices
  end

  def index
    @quizzes = Quiz.all
  end
end
