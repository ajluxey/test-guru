module ApplicationHelper
  BASE_GITHUB_URL = URI('https://github.com')

  def github_url(author, repo)
    BASE_GITHUB_URL + (author + '/' + repo)
  end

  def year_now
    Time.now.year
  end
end
