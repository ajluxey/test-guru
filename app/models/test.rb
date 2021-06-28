class Test < ApplicationRecord
  def self.all_by_category(cat_title)
    Test.joins('JOIN categories ON tests.category_id = categories.id')
        .where(categories: { title: cat_title })
        .order(:title, :desc)
        .pluck(:title)
  end
end
