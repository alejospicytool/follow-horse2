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
    @section_title = "Inicio"
    @navbar_brand = 'true'
    @search = 'true'
    @user = current_user
    @horses = Horse.all
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

  private

  def home_params
    params.require(:horse).permit(photos: [])
  end
end
