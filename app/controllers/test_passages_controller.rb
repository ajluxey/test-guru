class TestPassagesController < ApplicationController
  
  before_action :find_test_passage, only: %i[show update result gist]

  def show
  end

  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.complited?
      TestsMailer.complited_test(@test_passage).deliver_now
      BadgeManagerService.call(@test_passage)
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def result
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
