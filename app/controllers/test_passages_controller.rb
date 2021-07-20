class TestPassagesController < ApplicationController
  
  before_action :find_test_passage, only: %i[show update result gist]

  def show
  end

  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.complited?
      TestsMailer.complited_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def result
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call

    if result
      flash_options = { notice: t('.success') + result[:html_url] }
      @test_passage.user.gists.create!(question: @test_passage.current_question,
                                     url: result[:html_url])
    else
      flash_options = { alert: t('.failure') }
    end

    # flash_options = if result
    #   { notice: t('.success') + result[:url] }
    # else
    #   { alert: t('.failure') }
    # end
    
    redirect_to @test_passage, flash_options
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
