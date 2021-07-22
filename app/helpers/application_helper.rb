module ApplicationHelper

  def github_url(author, repo)
    link = "https://github.com/#{author}/#{repo}"
    link_to 'Github', link.to_s, target: '_blank', rel: 'nofollow'    
  end

  def year_now
    Time.current.year
  end

  def flash_messages
    content_tag :div do
      flash.collect do |key, message|
        concat content_tag :p, message.html_safe, class: "flash #{key}"
      end
    end
  end
end
