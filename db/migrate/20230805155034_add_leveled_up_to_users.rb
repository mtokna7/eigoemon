class AddLeveledUpToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :leveled_up, :boolean, default: false
  end
end
