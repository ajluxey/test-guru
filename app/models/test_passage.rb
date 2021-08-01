class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_next_question, on: :update, if: -> { still_have_time? }

  PASSAGE_TRESHOLD = 85

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    save!
  end

  def complited?
    current_question.nil?
  end

  def successfully_passed?
    calculate_result > PASSAGE_TRESHOLD
  end

  def calculate_result
    if self.correct_questions > 0
      self.correct_questions.to_f / self.test.questions.count * 100
    else
      0
    end
  end

  def time_left
    created_at + test.time_to_pass_duration - Time.current
  end

  def still_have_time?
    return true unless test.with_timer?
    time_left > 0
  end

  def finish!
    self.current_question = nil
    save
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_validation_set_next_question
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end
end
