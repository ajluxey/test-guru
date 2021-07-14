module ApplicationHelper
  BASE_GITHUB_URL = URI('https://github.com')

  def github_url(author, repo)
    link = BASE_GITHUB_URL + (author + '/' + repo)
    link_to 'Github', link.to_s, target: '_blank', rel: 'nofollow'    
  end

  def year_now
    Time.current.year
  end
end
