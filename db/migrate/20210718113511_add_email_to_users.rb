class AddEmailToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string

    reversible do |dir|
      User.all.each do |u|
        dir.up { u.email = u.login + '@mail.ru' }
        u.save
      end
    end
    
    change_column_null :users, :email, true
    add_index :users, :email, unique: true
  end
end
