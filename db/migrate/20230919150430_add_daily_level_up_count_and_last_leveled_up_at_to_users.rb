class AddDailyLevelUpCountAndLastLeveledUpAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :daily_level_up_count, :integer, default: 0
    add_column :users, :last_leveled_up_at, :datetime
  end
end
