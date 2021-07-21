class GistsController < ApplicationController
  def create
    test_passage = TestPassage.find(params[:test_passage_id])
    gist_result = GistQuestionService.new(test_passage.current_question).call

    if gist_result.success?
      flash_options = { notice: t('.success') + gist_result.url }
      test_passage.user.gists.create!(question: test_passage.current_question,
                                      url: gist_result.url)
    else
      flash_options = { alert: t('.failure') }
    end

    redirect_to test_passage, flash_options
  end
end
