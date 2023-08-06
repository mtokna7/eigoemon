class RenameDialoguesToConversations < ActiveRecord::Migration[7.0]
  def change
    rename_table :dialogues, :conversations
  end
end
