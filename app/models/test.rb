class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  
  has_many :questions, dependent: :destroy
  has_many :test_users,
           class_name: 'UsersStartTest',
           dependent: :destroy

  has_many :is_started_by_users,
           through: :test_users,
           source: :user,
           dependent: :destroy

  def self.all_by_category(cat_title)
    Test.joins('JOIN categories ON tests.category_id = categories.id')
        .where(categories: { title: cat_title })
        .order(:title, :desc)
        .pluck(:title)
  end
end
