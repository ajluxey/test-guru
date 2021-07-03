class CreateUsersTestsProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :users_tests_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.boolean :passed, default: false

      t.timestamps
    end

    add_index :users_tests_progresses, [:user_id, :test_id], unique: true
  end
end
