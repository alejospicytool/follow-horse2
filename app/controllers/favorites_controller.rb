class FavoritesController < ApplicationController
  def update_horse
    favorite = Favorite.where(horse: Horse.find(params[:horse]))
    if favorite == []
      @favorite = Favorite.create(horse: Horse.find(params[:horse]), user: current_user)
      @favorite_exists = true
      # @notification = Notification.create(
      #   user_id: current_user.id,
      #   description: "realizó una nueva publicación.",
      #   tipo: "favorite_horse",
      #   favorite_id: @favorite.id
      # )
    else
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.json { render json: { favorite_exists: @favorite_exists } }
    end
  end

  def delete_horse
    favorite = Favorite.where(horse_id: params[:id])
    favorite.destroy_all
    redirect_to profile_favorite_caballos_path
  end

  def update_auction
    favorite = Favorite.where(auction: Auction.find(params[:auction]))
    if favorite == []
      @favorite = Favorite.create(auction: Auction.find(params[:auction]), user: current_user)
      @favorite_exists = true
      # @notification = Notification.create(
      #   user_id: current_user.id,
      #   description: "realizó una nueva publicación.",
      #   tipo: "favorite_auction",
      #   favorite_id: @favorite.id
      # )
    else
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def delete_auction
    favorite = Favorite.where(auction_id: params[:id])
    favorite.destroy_all
    redirect_to profile_favorite_remates_path
  end

end
