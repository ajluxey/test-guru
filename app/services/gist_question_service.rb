class GistQuestionService

  ACCESS_TOKEN = Rails.application.credentials.github_gists_token

  GistResult = Struct.new(:url) do
    def success?
      !self.url.nil?
    end
  end

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: ACCESS_TOKEN)
  end

  def call
    response = @client.create_gist(gist_params)
  rescue
    GistResult.new
  else
    GistResult.new(response[:html_url])
  end

  private

  def gist_params
    { 
      description: "A question about #{@test.title} from TestGuru",
      files: { 
        'test-guru-question.txt': { 
          content: gist_content 
        } 
      } 
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end
