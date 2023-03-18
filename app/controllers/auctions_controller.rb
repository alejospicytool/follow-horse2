class AuctionsController < ApplicationController
  before_action :set_auction, only: %i[auction edit update destroy]
  before_action :sub_links

  def next_auctions
    @auctions = Auction.all
    @section_title = "Remates"
    @navbar_brand = 'true'
  end

  def active_auctions
    @auctions = Auction.all
    @section_title = "Remates"
    @navbar_brand = 'true'
  end

  def show
    @user = current_user
    @auction = Auction.find(params[:id])
    @auctions = Auction.where(user: current_user)
    @section_title = @auction.name
  end

  def new
    @auction = Auction.new
    @user = current_user
    @section_title = "Añadir Remate"
  end

  def create
    @user = current_user
    @auction = Auction.create(auction_params)
    @auction.user = @user
    if @auction.save
      redirect_to next_auctions_path
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

  def sub_links
    @sub_links = [
      {title: "Activos", path: active_auctions_path},
      {title: "Proximos", path: next_auctions_path}
    ]
  end

  private

  def set_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:name, :location, :date, :start, :finish)
  end
end
