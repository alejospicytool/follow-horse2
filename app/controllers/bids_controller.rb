class BidsController < ApplicationController
  before_action :set_horse, only: %i[show edit update delete destroy]
  def index
    @bids = Horse.all
  end

  def new
    @bid = Horse.new
    @user = current_user
  end

  def create
    @user = current_user
    @bid = Bid.create(bid_params)
    @bid.user = @user
    if @horse.save
      redirect_to horses_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @horse.destroy
    redirect_to horses_path, status: :see_other
  end

  private

  def set_bid
    @bid = Horse.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(:amount, :winning)
  end
end
