class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  
  has_many :questions, dependent: :destroy
  has_many :test_passages,
           dependent: :destroy

  has_many :is_started_by_users,
           through: :test_passages,
           source: :user
  
  scope :easy, -> { where(level: 0..1) }
  scope :middle, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  
  scope :all_by_category, ->(category_title) do
    joins(:category)
    .where(categories: { title: category_title })
    .order(:title, :desc)
    .pluck(:title)
  end

  validates :title, presence: true
  validates :title, uniqueness: { scope: :level }
  validates :level, numericality: { greater_than_or_equal_to: 0,
                                    only_integer: true }
end
