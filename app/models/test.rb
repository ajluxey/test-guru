class Test < ApplicationRecord
  def self.all_by_category(cat_title)
    category = Category.find_by(title: cat_title)
    Test.where(category_id: category.id).order(:title, :desc) if category
  end
end
