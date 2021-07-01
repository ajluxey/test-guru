class CreateJoinTableUsersStartTests < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :tests, table_name: :users_start_tests  do |t|
      # t.integer :user_id, null: false
      # t.integer :test_id, null: false
      t.index [:user_id, :test_id], unique: true
      # t.index [:test_id, :user_id]
    end
  end
end