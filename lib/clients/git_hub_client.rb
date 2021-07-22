class GitHubClient
  
  ACCESS_TOKEN = Rails.application.credentials.github_gists_token

  def initialize
    @client = Octokit::Client.new(access_token: ACCESS_TOKEN)
  end

  def create_gist(params)
    @client.create_gist(params)
  end

end