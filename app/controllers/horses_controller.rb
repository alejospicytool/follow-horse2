require 'net/http'
require 'net/http/post/multipart'
class HorsesController < ApplicationController
  before_action :set_horse, only: %i[show edit update destroy]
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
    @conversation = Conversation.new
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
    uploaded_file = horse_params[:video]
    name = ''
    url = post_video_to_wistia(name, horse_params[:video])
    @horse.video = url
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
  def filtros
    @filtro = Filtro.new
    @horses = Horse.all.where.not(user_id: current_user.id)
    @jinetes = @horses.map { |horse| horse.rider }.uniq
    @height = ["0.5", "0.6", "0.7", "0.8", "0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "1.9", "2.0"]
    @ubicaciones = @horses.map { |horse| User.find(horse.user_id).ciudad }.uniq
    @section_title = "Caballos - Filtros"
  end
  def aplicarfiltros
    jinete = params[:filtro][:jinete]
    edad = params[:filtro][:edad]
    altura = params[:filtro][:altura]
    ubicacion = params[:filtro][:ubicacion]
    redirect_to horses_results_path(filtro: "OK", jinete: jinete, edad: edad, altura: altura, ubicacion: ubicacion)
  end
  def resultados
    @section_title = "Resultados"
    @filtros = 'true'
    # Resultados
    if params[:filtro] == "OK"
      @horses_all = Horse.all.where.not(user_id: current_user.id)
      @horses = Horse.all.where.not(user_id: current_user.id)
      # Filtro por jinete
      if params[:jinete] != ""
        @horses = @horses_all.where(rider: params[:jinete])
      end
      # Filtro por Edad
      if params[:edad] != "0"
        if @horses
          @horses = @horses.where(age: params[:edad])
        else
          @horses = @horses_all.where(age: params[:edad])
        end
      end
      # Filtro por Altura
      if params[:altura] != ""
        if @horses
          @horses = @horses.where(height: params[:altura].to_s)
        else
          @horses = @horses_all.where(height: params[:altura].to_s)
        end
      end
      # Filtro por Ubicacion
      if params[:ubicacion] != ""
        if @horses
          @horses = @horses.where(user_id: User.where(ciudad: params[:ubicacion]).pluck(:id))
        else
          @horses = @horses_all.where(user_id: User.where(ciudad: params[:ubicacion]).pluck(:id))
        end
      end
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
  def post_video_to_wistia(name = "", path_to_video)
    uri = URI('https://upload.wistia.com/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # Construct the request.
    request = Net::HTTP::Post::Multipart.new uri.request_uri, {
      'access_token' => "596f97ec721a7997a641b5bd4c64f4e1f838d99e34d2dca91c8ccd46d1c18c8a",
      'file' => UploadIO.new(
                  File.open(path_to_video),
                  'application/octet-stream',
                  File.basename(path_to_video)
                )
    }
    # Make it so!
    response = http.request(request)
    id =  JSON.parse(response.body)["thumbnail"]["url"]
    id = id.split('/').last.split('.').first
    url = "http://embed.wistia.com/deliveries/#{id}.bin"


    return url

  end
  private
  def set_horse
    @horse = Horse.find(params[:id])
  end
  def horse_params
    params.require(:horse).permit(:rider, :name, :description, :birthday, :age, :height, :gender, :alzada, :pedigree, :video, photos: [])
  end
end
