class Admin::BadgesController < Admin::BaseController
  before_action :find_badge, only: %i[ show edit update destroy ]
  before_action :set_rules, only: %i[ new edit create update ]

  def index
    @badges = Badge.all
  end

  def show
  end

  def new
    @badge = Badge.new
  end

  def edit
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to @badge, notice: "Badge was successfully created."
    else
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to @badge, notice: "Badge was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to badges_url, notice: "Badge was successfully destroyed."
  end

  private

  def find_badge
    @badge = Badge.find(params[:id])
  end

  def set_rules
    @rules = BadgeCreationService.rules_collection 
  end

  def badge_params
    BadgeCreationService.badge_params(params)
  end
end
