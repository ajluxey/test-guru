module BadgesHelper
  def show_user_badges(user_badges)
    if user_badges
      content_tag(:h1, 'Your badges:') +
      (render partial: 'badges/badge', collection: user_badges) +
      content_tag(:h3, 'But you can get more:')
    else
      content_tag(:h1, "You have no badges now. But you can get!")
    end
  end
end
