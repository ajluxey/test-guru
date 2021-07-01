class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  
  has_many :questions, dependent: :destroy
  has_many :users_start_tests,
           dependent: :destroy

  has_many :is_started_by_users,
           through: :users_start_tests,
           source: :user

  def self.all_by_category(cat_title)
    joins(:category) 
    .where(categories: { title: cat_title })
    .order(:title, :desc)
    .pluck(:title)
  end
end
