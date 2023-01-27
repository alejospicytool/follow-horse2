class AuctionsController < ApplicationController
  before_action :set_auction, only: %i[show edit update delete destroy]
  def index
    @auctions = Auction.where(user: current_user)
  end

  def new
    @auction = Auction.new
    @user = current_user
  end

  def create
    @user = current_user
    @auction = Auction.create(auction_params)
    @auction.user = @user
    if @auction.save
      redirect_to auctions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @auction.update(auction_params)
      redirect_to auctions_path(@auction)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @auction.destroy
    redirect_to auctions_path, status: :see_other
  end

  private

  def set_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:name, :location, :date, :photo)
  end
end
