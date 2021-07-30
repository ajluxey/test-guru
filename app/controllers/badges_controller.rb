class BadgesController < ApplicationController
  def index
    if current_user.has_badges?
      @user_badges = current_user.badges
      @badges = Badge.find(Badge.ids - current_user.badge_ids)
    else
      @badges = Badge.all
    end
  end

  def show
    @badge = Badge.find(params[:id])
  end
end
