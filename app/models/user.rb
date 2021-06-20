class User < ApplicationRecord
  def get_passed_tests_with_level(n)
    Test.joins('JOIN users_start_tests ON users_start_tests.test_id = tests.id')
        .joins('JOIN users ON users_start_tests.user_id = users.id')
        .where(users: { id: self.id })
        .where(level: n)
  end
end
