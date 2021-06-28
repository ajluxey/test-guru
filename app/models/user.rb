class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id'
  has_and_belongs_to_many :started_tests, join_table: 'users_start_tests', class_name: 'Test'

  def get_passed_tests_with_level(n)
    Test.joins('JOIN users_start_tests ON users_start_tests.test_id = tests.id')
        .where(users_start_tests: { user_id: self.id })
        .where(level: n)
  end
end
