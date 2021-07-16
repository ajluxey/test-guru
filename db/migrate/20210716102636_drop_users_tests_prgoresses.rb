class DropUsersTestsPrgoresses < ActiveRecord::Migration[6.1]
  def up
    drop_table :users_tests_progresses, if_exist: true
  end
end
