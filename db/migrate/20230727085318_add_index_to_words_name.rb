class AddIndexToWordsName < ActiveRecord::Migration[7.0]
  def change
    add_index :words, :name, unique: true
  end
end
