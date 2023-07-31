class RenameQuizIdInUserQuizHistories < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_quiz_histories, :quiz_id, :word_id
  end
end
