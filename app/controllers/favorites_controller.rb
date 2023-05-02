class FavoritesController < ApplicationController
  def update
    favorite = Favorite.where(horse: Horse.find(params[:horse]))
    if favorite == []
      Favorite.create(horse: Horse.find(params[:horse]), user: current_user)
      @favorite_exists = true
    else
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end
