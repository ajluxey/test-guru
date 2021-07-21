class GistsController < ApplicationController
  def create
    test_passage = TestPassage.find(params[:test_passage_id])
    gist_result = GistQuestionService.new(test_passage.current_question).call

    if gist_result.success?
      link = view_context.link_to('gists.github.com', gist_result.url, target:"_blank", rel: "nofollow")
      flash_options = { notice: t('.success', link: link) }
      test_passage.user.gists.create!(question: test_passage.current_question,
                                      url: gist_result.url)
    else
      flash_options = { alert: t('.failure') }
    end

    redirect_to test_passage, flash_options
  end
end
