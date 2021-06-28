class CreateJoinTableUsersStartTests < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :tests, table_name: :users_start_tests  do |t|
      t.index [:user_id, :test_id]
      t.index [:test_id, :user_id]
    end
  end
end
