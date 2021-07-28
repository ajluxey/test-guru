class TestsController < ApplicationController

  before_action :find_test, only: %i[show edit update destroy start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def start
    test_passage = current_user.test_passage(@test)
    test_passage = current_user.test_passages.create(test: @test) if !test_passage.present? || test_passage.complited?
    redirect_to test_passage
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: "Test with id = #{params[:id]} not found"
  end
end
