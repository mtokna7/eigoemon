class AddOrderToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :order, :integer
  end
end
