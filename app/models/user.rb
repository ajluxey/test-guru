class User < ApplicationRecord
  has_many :created_tests,
           foreign_key: 'author_id',
           class_name: 'Test',
           dependent: :destroy

  has_many :user_tests,
           class_name: 'UsersStartTest',
           dependent: :destroy

  has_many :started_tests,
           through: :user_tests,
           source: :test,
           dependent: :destroy

  def get_passed_tests_with_level(n)
    Test.joins('JOIN users_start_tests ON users_start_tests.test_id = tests.id')
        .where(users_start_tests: { user_id: self.id })
        .where(level: n)
  end
end
