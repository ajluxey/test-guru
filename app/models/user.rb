class User < ApplicationRecord
  has_and_belongs_to_many :tests, join_table: 'users_start_tests'

  def get_ex_tests_with_level(n)
    self.tests.where(level: n)
  end
end
