class TestPassagesController < ApplicationController
  
  before_action :find_test_passage, only: %i[show result update]

  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.complited?
      redirect_to result_test_passage(@test_passage)
    else
      render :show
    end
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
