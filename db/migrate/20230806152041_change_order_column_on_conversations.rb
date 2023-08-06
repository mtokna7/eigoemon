class ChangeOrderColumnOnConversations < ActiveRecord::Migration[7.0]
  def change
    change_column_null :conversations, :order, false
  end
end
