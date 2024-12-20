class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :onboarding, :slide1, :slide2, :slide3 ]
  before_action :set_user, only: %i[show]

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
    @section_title = "Inicio"
    @navbar_brand = 'true'
    @user = current_user
    ## @horses = Horse.select do |horse|
    ##   horse.user.id != current_user.id
    ## end
    @horses = Horse.all.where.not(user_id: current_user.id).order("created_at DESC")
    @pub_imgs = Pub.all.where(asset_type: "photo")
  end

  def search
    @section_title = "Categorias"
    @navbar_brand = 'true'
    @search = 'true'
  end

  def add
    @section_title = "Añadir publicación"
    @navbar_brand = 'true'
    @search = 'true'
  end

  def profile_index
    @user = current_user
  end

  def gracias
    @disable_nav = true
  end

  def profile_show
    @user = User.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def home_params
    params.require(:horse).permit(photos: [])
  end
end
