class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_answer_count

  scope :correct, -> { where(correct: true) }

  private

  def validate_answer_count
    errors.add(:question, 'question can contain max 4 answers') if question.answers.count == 4
  end
end
