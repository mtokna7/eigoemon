class TutorialsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[
    quiz_show quiz_explanation library_index library_explanation autocomplete
  ]
  before_action :set_quiz_sequence, only: %i[quiz_show quiz_explanation]
  before_action :next_quiz, only: %i[quiz_show]
  before_action :load_quiz, only: %i[quiz_show quiz_explanation]

  TUTORIAL_WORD_IDS = [1, 4, 7].freeze

  def quiz_show
    @word_name = @quiz.word.name
    @quiz_choices = @quiz.quiz_choices
    redirect_to root_path unless @quiz.id == @current_quiz_id
  end

  def quiz_explanation
    @word = Word.find(params[:id])
    correct_choice = @quiz.quiz_choices.find_by(is_correct: true)
    @is_correct = params[:choice_id].to_i == correct_choice.id if correct_choice
    redirect_to root_path unless can_access_tutorial?
  end

  def library_index
    @words = Word.order(:name).all
  end

  def autocomplete
    query = params[:q]
    words = Word.where('name ILIKE ?', "%#{query}%").limit(10)
    render partial: 'tutorial_autocomplete_results', locals: { words: words }
  end

  def library_explanation
    @word = Word.find(params[:word_id])
    redirect_to library_index_tutorials_path, alert: t("alert.need_sign_in") unless can_access_tutorial?
  end

  private

  def quiz_index_out_of_range?
    session[:quiz_index].nil? || session[:quiz_index] >= TUTORIAL_WORD_IDS.size
  end

  def set_quiz_sequence
    session[:quiz_index] = 0 if quiz_index_out_of_range?
    @current_quiz_id = TUTORIAL_WORD_IDS[session[:quiz_index]]
  end

  def load_quiz
    @quiz = Quiz.find_by(id: @current_quiz_id)
  end

  def next_quiz
    session[:quiz_index] += 1
    session[:quiz_index] = 0 if quiz_index_out_of_range?
    @current_quiz_id = TUTORIAL_WORD_IDS[session[:quiz_index]]
  end

  def can_access_tutorial?
    user_signed_in? || TUTORIAL_WORD_IDS.include?(@word.id)
  end
end
