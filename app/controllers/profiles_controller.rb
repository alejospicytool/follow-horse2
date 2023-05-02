class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :sub_links

  def profile_index
    @section_title = "Mi perfil"
  end

  def show
    @user = User.find(params[:id])
    @horses = Horse.where(user_id: @user.id)
    @section_title = @user.nombre + " " + @user.apellido
    @review = Review.new
    @reviews = Review.where(user: current_user)
  end

  def rite_caballos
    @section_title = "Favoritos"
    @horses = Horse.all.where(user_id: current_user)
  end

  def favorite_remates
    @section_title = "Favoritos"
    @auctions = Auction.all.where(user_id: current_user)
  end


  def notification
    @section_title = "Notificaciones"
  end

  def publication_caballos
    @section_title = "Mis publicaciones"
    @horses = Horse.all.where(user_id: current_user)
  end

  def publication_remates
    @section_title = "Mis publicaciones"
    @auctions = Auction.all.where(user_id: current_user)
  end

  def sub_links
    @sub_links_publicaciones = [
      { title: "Caballos", path: profile_publication_caballos_path },
      { title: "Remates", path: profile_publication_remates_path }
    ]

    @sub_links_favoritos = [
      { title: "Caballos", path: profile_favorite_caballos_path },
      { title: "Remates", path: profile_favorite_remates_path }
    ]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
