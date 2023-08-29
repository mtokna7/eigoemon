class TutorialsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[quiz_show quiz_explanation library_index library_explanation]
  before_action :set_quiz_sequence, only: %i[quiz_show quiz_explanation]
  before_action :next_quiz, only: %i[quiz_show]
  before_action :load_quiz, only: %i[quiz_show quiz_explanation]

  def quiz_show
    @word_name = @quiz.word.name
    @quiz_choices = @quiz.quiz_choices
    redirect_to root_path, alert: "アクセス権限がありません。" unless @quiz.id == @current_quiz_id
    # alertの表示方法確認
  end

  def quiz_explanation
    @word = Word.find(params[:id])
    correct_choice = @quiz.quiz_choices.find_by(is_correct: true)
    @is_correct = params[:choice_id].to_i == correct_choice.id if correct_choice
    redirect_to root_path unless user_signed_in? || [1, 4, 7].include?(@word.id)
  end

  def library_index
    @words = Word.order(:name).all
  end

  def library_explanation
    @word = Word.find(params[:word_id])
    redirect_to library_index_tutorials_path unless user_signed_in? || [1, 4, 7].include?(@word.id)
  end

  private

  def set_quiz_sequence
    @sequence = [1, 4, 7]
    session[:quiz_index] = 0 if session[:quiz_index].nil? || session[:quiz_index] >= @sequence.size
    @current_quiz_id = @sequence[session[:quiz_index]]
  end

  def load_quiz
    @quiz = Quiz.find_by(id: @current_quiz_id)
  end

  def next_quiz
    session[:quiz_index] += 1
    session[:quiz_index] = 0 if session[:quiz_index] >= @sequence.size
    @current_quiz_id = @sequence[session[:quiz_index]]
  end
end
