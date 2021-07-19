module ApplicationHelper

  def github_url(author, repo)
    link = "https://github.com/#{author}/#{repo}"
    link_to 'Github', link.to_s, target: '_blank', rel: 'nofollow'    
  end

  def year_now
    Time.current.year
  end

  def flash_message(key)
    content_tag :p, flash[key], class: "flash #{key}" if flash[key]
  end

end
