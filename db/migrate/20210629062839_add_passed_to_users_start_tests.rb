class AddPassedToUsersStartTests < ActiveRecord::Migration[6.1]
  def change
    add_column :users_start_tests, :passed, :boolean, default: false
  end
end
