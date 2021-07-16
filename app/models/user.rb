class User < ApplicationRecord
  has_many :created_tests,
           foreign_key: 'author_id',
           class_name: 'Test',
           dependent: :destroy

  has_many :test_passages,
           dependent: :destroy

  has_many :started_tests,
           through: :test_passages,
           source: :test

  validates :login, presence: true

  def get_passed_tests_with_level(level)
    Test.joins(:test_passages)
        .where('user_id = ?', id)
        .where(users_tests_progress: { passed: true })
        .where(level: level)
  end
end
