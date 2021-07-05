class User < ApplicationRecord
  has_many :created_tests,
           foreign_key: 'author_id',
           class_name: 'Test',
           dependent: :destroy

  has_many :users_tests_progress,
           dependent: :destroy

  has_many :started_tests,
           through: :users_tests_progress,
           source: :test

  validates :login, presence: true

  def get_passed_tests_with_level(level)
    Test.joins(:users_tests_progress)
        .where('user_id = ?', id)
        .where(users_tests_progress: { passed: true })
        .where(level: level)
  end
end
