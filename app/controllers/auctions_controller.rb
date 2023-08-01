class AuctionsController < ApplicationController
  before_action :set_auction, only: %i[auction edit update destroy]
  before_action :sub_links

  def next_auctions
    @auctions = Auction.all.where.not(user_id: current_user.id)
    @auctions = @auctions.where("start > ?", Time.now)
    @section_title = "Remates"
    @navbar_brand = 'true'
  end

  def active_auctions
    @auctions = Auction.all.where.not(user_id: current_user.id)
    @auctions = @auctions.where("start < ?", Time.now).where("finish > ?", Time.now)
    @section_title = "Remates"
    @navbar_brand = 'true'
  end

  def show
    @auction = Auction.find(params[:id])
    @section_title = @auction.name.capitalize
  end

  def new
    @auction = Auction.new
    @section_title = "Añadir Remate"
  end

  def create
    @auction = Auction.create(auction_params)
    @auction.user = current_user
    if @auction.save
      redirect_to profile_publication_remates_path
    else
      @section_title = "Añadir Remate"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @section_title = "Editar remate"
  end

  def update
    if @auction.update(auction_params)
      redirect_to auctions_path(@auction)
    else
      @section_title = "Editar remate"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @auction = Auction.find(params[:id])
    if @auction.destroy
      if params[:mis_publicaciones]
        redirect_to profile_publication_remates_path, notice: "Se elimino correctamente la publicacion"
      else
        redirect_to auctions_path, notice: "Se elimino correctamente la publicacion"
      end
    else
      render 'mis_publicaciones/remates', alert: "No se pudo eliminar la publicacion, intente nuevamente"
    end
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
    params.require(:auction).permit(:name, :location, :start, :finish, :photo, :condiciones, :link_auction)
  end
end
