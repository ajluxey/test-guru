class Test < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :users, join_table: 'users_start_tests'

  def self.all_by_category(cat_title)
    Test.joins(:category).where(category: { title: cat_title })
  end
end
