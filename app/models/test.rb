class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  
  has_many :questions, dependent: :destroy
  has_many :users_start_tests,
           class_name: 'UsersStartTest',
           dependent: :destroy

  has_many :is_started_by_users,
           through: :users_start_tests,
           source: :user,
           dependent: :destroy

  def self.all_by_category(cat_title)
    Test.joins(:category) 
        .where(categories: { title: cat_title })
        .order(:title, :desc)
        .pluck(:title)
  end
end
