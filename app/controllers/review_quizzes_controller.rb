class ReviewQuizzesController < ApplicationController
  def generate
    @user = current_user
    @quiz = Quiz.get_review_quiz_for_user(@user)
    if @quiz
      redirect_to review_quiz_path(@quiz)
    else
      # 適切なクイズが見つからない場合の処理（例: ルートページにリダイレクト）
      redirect_to root_path
    end
  end
  
  def show
    @user = current_user
    @quiz = Quiz.find(params[:id])  # IDに基づいてクイズを取得
    @quiz_choices = @quiz.quiz_choices  # その他、必要なデータを取得
  end

  def explanation
    @word = Word.find(params[:id])
    chosen_quiz_choice = QuizChoice.find(params[:choice_id])
    @user_quiz_history = current_user.record_quiz_history(chosen_quiz_choice)
  end
end
