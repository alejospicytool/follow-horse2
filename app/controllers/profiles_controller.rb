class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show]

  def profile_index
    @section_title = "Mi perfil"
  end

  def show
    @user = User.find(params[:id])
  end

  def favourite
    @section_title = "Favoritos"
  end

  def notification

  end

  def publication
    @section_title = "Mis publicaciones"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
