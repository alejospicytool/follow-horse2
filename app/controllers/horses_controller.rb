class HorsesController < ApplicationController
  before_action :set_horse, only: %i[show edit update delete destroy]

  def index
    @horses = Horse.all.where.not(user_id: current_user.id)
    @section_title = "Caballos"
    @filtros = 'true'
  end

  def potros
    @horses_user = Horse.all.where.not(user_id: current_user.id)
    @horses = @horses_user.select do |horse|
      horse.age <= 4
    end
    @section_title = "Potros"
    @filtros = 'true'
  end

  def show
    @section_title = @horse.name
    @horse = Horse.find(params[:id])
    @horses = Horse.all.where.not(user_id: current_user.id).where.not(id: params[:id].to_i)
    @share_like = 'true'
    @favorite_exists = Favorite.where(horse: @horse, user: current_user) != []
  end

  def new
    @horse = Horse.new
    @section_title = "Añadir caballo"
    @alzada = ["0.5", "0.6", "0.7", "0.8", "0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "1.9", "2.0"]
    @height = ["0.5", "0.6", "0.7", "0.8", "0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "1.9", "2.0"]
  end

  def create
    @horse = Horse.create(horse_params)
    @horse.user = current_user
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
