class RenameWordIdInUserQuizHistories < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_quiz_histories, :word_id, :quiz_id
  end
end
