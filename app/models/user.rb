class User < ApplicationRecord
  def get_tests_with_level(n)
    Test.find_by(level: n)
  end
end
