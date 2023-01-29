class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :onboarding, :slide1, :slide2, :slide3 ]

  def onboarding
    @disable_nav = true
  end

  def slide1
    @disable_nav = true
  end

  def slide2
    @disable_nav = true
  end

  def slide3
    @disable_nav = true
  end

  def home
  end
end
