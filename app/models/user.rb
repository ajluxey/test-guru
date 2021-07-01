class User < ApplicationRecord
  has_many :created_tests,
           foreign_key: 'author_id',
           class_name: 'Test',
           dependent: :destroy

  has_many :users_start_tests,
           dependent: :destroy

  has_many :started_tests,
           through: :users_start_tests,
           source: :test

  def get_passed_tests_with_level(n)
    Test.joins(:users_start_tests).where('user_id = ?', id).where('passed').where(level: n)
  end
end
