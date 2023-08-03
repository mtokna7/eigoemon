class CreateDialogues < ActiveRecord::Migration[7.0]
  def change
    create_table :dialogues do |t|
      t.integer :level, null: false
      t.text :content, null: false
      t.integer :speaker, null: false, default: 0

      t.timestamps
    end
  end
end
