class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :name, null: false
      t.text :programming_explanation, null: false
      t.text :english_explanation, null: false
      t.string :furigana, null: false
      t.integer :bold_start
      t.integer :bold_end

      t.timestamps
    end
  end
end
