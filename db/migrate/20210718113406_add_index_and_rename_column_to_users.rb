class AddIndexAndRenameColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :login, unique: true
    rename_column :users, :password, :password_digest
  end
end
