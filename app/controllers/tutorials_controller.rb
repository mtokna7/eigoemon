class TutorialsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[quiz_show quiz_explanation next]
  before_action :set_quiz_sequence, only: %i[quiz_show quiz_explanation next]
  before_action :load_quiz, only: %i[quiz_show quiz_explanation]

  def quiz_show
    @word_name = @quiz.word.name
    @quiz_choices = @quiz.quiz_choices
  end

  def quiz_explanation
    @word = Word.find(params[:id])
    correct_choice = @quiz.quiz_choices.find_by(is_correct: true)
    @is_correct = params[:choice_id].to_i == correct_choice.id if correct_choice
  end

  def next
    next_quiz
  end

  def library_index
    @words = Word.all
  end

  private

  def set_quiz_sequence
    @sequence = [1, 5, 4]
    if session[:quiz_index].nil? || session[:quiz_index] >= @sequence.size
      session[:quiz_index] = 0
    end
    @current_quiz_id = @sequence[session[:quiz_index]]
  end

  def load_quiz
    @quiz = Quiz.find_by(id: @current_quiz_id)
  end

  def next_quiz
    session[:quiz_index] += 1
    
    if session[:quiz_index] >= @sequence.size
      session[:quiz_index] = 0
      redirect_to quiz_show_tutorial_path(@sequence[0])
    else
      redirect_to quiz_show_tutorial_path(@sequence[session[:quiz_index]])
    end
  end
end
