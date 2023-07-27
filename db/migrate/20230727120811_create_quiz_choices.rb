class CreateQuizChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_choices do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :furigana
      t.boolean :is_correct
      t.integer :bold_start
      t.integer :bold_end

      t.timestamps
    end
  end
end
