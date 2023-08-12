class AddFirstTimeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_visit, :boolean, default: true
  end
end
