class CreateUserQuizHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_quiz_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.references :quiz_choice, null: false, foreign_key: true
      t.boolean :is_correct, null: false, default: false

      t.timestamps
    end
  end
end
