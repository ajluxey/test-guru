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

  validates :email, presence: true, 
                    uniqueness: true, 
                    format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'Incorrect Email' }
                              
  validates :login, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password

  # TODO: rework
  def get_passed_tests_with_level(level)
    Test.joins(:test_passages)
        .where('user_id = ?', id)
        .where(users_tests_progress: { passed: true })
        .where(level: level)
  end

  # method which return last attempt to pass test
  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
