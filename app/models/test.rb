class Test < ApplicationRecord
  has_many :questions
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :is_started_by_users, join_table: 'users_start_tests', class_name: 'User'

  def self.all_by_category(cat_title)
    Test.joins('JOIN categories ON tests.category_id = categories.id')
        .where(categories: { title: cat_title })
        .order(:title, :desc)
        .pluck(:title)
  end
end
