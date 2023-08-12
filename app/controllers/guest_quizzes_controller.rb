class GuestQuizzesController < ApplicationController
    GUEST_QUIZ_IDS = [1, 7, 4].freeze
  
    def show
      @quiz_id = session[:guest_quiz_position] || 0
      if @quiz_id >= GUEST_QUIZ_IDS.length
        redirect_to guest_end_path # 例: ゲストユーザー向けの終了ページへのパス
      end
  
      @quiz = Quiz.find(GUEST_QUIZ_IDS[@quiz_id])
      @quiz_choices = @quiz.quiz_choices
    end

    def info; end
  end
  