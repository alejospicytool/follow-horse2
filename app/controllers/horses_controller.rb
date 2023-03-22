class HorsesController < ApplicationController
  before_action :set_horse, only: %i[show edit update delete destroy]

  def index
    @horses = Horse.all
    @section_title = "Caballos"
    @filtros = 'true'
  end

  def show
    @user_id = current_user.id
    @horse = Horse.find(params[:id])
    @horses = Horse.all.select do |horse|
      @horse.id != horse.id
    end
    @share_like = 'true'
  end

  def new
    @horse = Horse.new
    @user = current_user
    @section_title = "Añadir caballo"
    @alzada = ["0.5", "0.6", "0.7", "0.8", "0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "1.9", "2.0"]
    @height = ["0.5", "0.6", "0.7", "0.8", "0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "1.9", "2.0"]
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
    @horse = Horse.find(params[:id])
    if @horse.destroy
      if params[:mis_publicaciones]
        redirect_to profile_publication_caballos_path, notice: "Se elimino correctamente la publicacion"
      else
        redirect_to horses_path, notice: "Se elimino correctamente la publicacion"
      end
    else
      render 'mis_publicaciones/caballos', alert: "No se pudo eliminar la publicacion, intente nuevamente"
    end
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:rider, :name, :description, :birthday, :age, :height, :gender, :alzada, :pedigree, :video, photos: [])
  end
end
