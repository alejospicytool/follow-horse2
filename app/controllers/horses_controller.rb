class HorsesController < ApplicationController
  before_action :set_horse, only: %i[show edit update delete destroy]
  def index
    @horses = Horse.where(user: current_user)
  end

  def show
  end

  def new
    @horse = Horse.new
    @user = current_user
  end

  def create
    @user = current_user
    @horse = Horse.create(horse_params)
    @horse.user = @user
    if @horse.save
      redirect_to horses_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @horse.update(horse_params)
      redirect_to horses_path(@horse)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @horse.destroy
    redirect_to horses_path, status: :see_other
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:name, :pedigree, :age, :description, :photo)
  end
end
