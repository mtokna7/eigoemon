class AddUniqueIndexToConversations < ActiveRecord::Migration[7.0]
  def change
    add_index :conversations, [:order, :level], unique: true
  end
end
