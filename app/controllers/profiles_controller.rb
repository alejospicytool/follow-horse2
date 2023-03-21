class ProfilesController < ApplicationController

  def profile_index
    @section_title = "Mi perfil"
  end

  def show
  end

  def favourite
    @section_title = "Favoritos"
  end

  def notification

  end

  def publication
    @section_title = "Mis publicaciones"
  end

end
