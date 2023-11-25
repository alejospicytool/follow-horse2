require 'net/http'
require 'net/http/post/multipart'

class HorsesController < ApplicationController

  ALLOWED_VIDEO_FORMATS = %w(
    video/quicktime video/mpeg video/avi video/x-flv video/x-f4v
    video/mp4 video/x-m4v video/x-ms-asf video/x-ms-wmv video/x-ms-wmx
    video/x-ms-wvx video/vob video/mod video/3gpp video/3gpp2
    video/x-matroska video/divx video/xvid video/webm
  )

  before_action :set_horse, only: %i[show edit update destroy]

  def initialize
    super
    numbers = []
    (0..220).each do |num|
      major = num / 100
      minor = num % 100
      if major >= 1 && major <= 2 && minor > 0
        numbers << "#{major}.#{format('%02d', minor)}"
      end
    end
    @alzada = numbers
    @height = ["0.50", "0.60", "0.70", "0.80", "0.90", "1.00", "1.10", "1.20", "1.30", "1.40", "1.50", "1.60", "1.70", "1.80", "1.90", "2.00"]
  end

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
    @horses = Horse.all.where(user_id: @horse.user.id).where.not(id: params[:id].to_i)
    @share_like = 'true'
    @conversation = Conversation.new
    @favorite_exists = Favorite.where(horse: @horse, user: current_user) != []
    if @horse.video != nil
      url = @horse.video
      url_path = url.sub("http://", "//")
      @horse.video = url_path
    end
  end

  def new
    @horse = Horse.new
    @section_title = "Añadir caballo"
  end

  def create
    @horse = Horse.create(horse_params)
    @horse.user = current_user

    if params[:horse][:photos].present?
      @horse.photos.attach(params[:horse][:photos])
    end

    if params[:horse][:food_photo].present?
      @horse.food_photo.attach(params[:horse][:food_photo])
    end
    
    if params[:horse][:video] != nil
      if ALLOWED_VIDEO_FORMATS.include?(params[:horse][:video].content_type)
        puts "--------------------------------"
        puts "Inicio post check de url"
        uploaded_file = horse_params[:video]
        name = ''
        url = post_video_to_wistia(name, horse_params[:video])
        if url == "Excedio el limite de videos"
          puts "--------------------------------"
          puts "Excedio el limite de videos"
          flash[:alert] = "No se pudo crear el caballo, se exedio el limite de videos"
          render :new, status: :unprocessable_entity
        else
          puts "--------------------------------"
          puts "Inicio post to wistia"
          @horse.video = url
          if @horse.save
            @notification = Notification.new(
              user_id: current_user.id,
              description: "Publicación creada con éxito.",
              tipo: "publication",
              horse_id: @horse.id
            )
            if @notification.save
              redirect_to profile_publication_caballos_path, notice: "Caballo creado con éxito"
            else
              @section_title = "Añadir caballo"
              flash[:alert] = "No se pudo crear el caballo, intente nuevamente"
              render :new, status: :unprocessable_entity
            end
          else
            @section_title = "Añadir caballo"
            flash[:alert] = "No se pudo crear el caballo, intente nuevamente"
            render :new, status: :unprocessable_entity
          end
        end
      else
        @section_title = "Añadir caballo"
        flash[:alert] = "Por favor cargue un video con formato válido"
        render :new, status: :unprocessable_entity
      end
    else
      if @horse.save
        @notification = Notification.new(
          user_id: current_user.id,
          description: "Publicación creada con éxito.",
          tipo: "publication",
          horse_id: @horse.id
        )
        redirect_to profile_publication_caballos_path, notice: "Caballo creado con éxito"
      else
        @section_title = "Añadir caballo"
        flash[:alert] = "No se pudo crear el caballo, intente nuevamente"
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @section_title = "Editar caballo"
    @horse = Horse.find(params[:id])
  end

  def update
    if params[:horse][:photos].present?
      @horse.photos.attach(params[:horse][:photos])
    end

    if params[:horse][:food_photo].present?
      @horse.food_photo.attach(params[:horse][:food_photo])
    end    

    # If the video is uploaded
    if horse_params[:video] != nil
      if ALLOWED_VIDEO_FORMATS.include?(params[:horse][:video].content_type)
        puts "--------------------------------"
        puts "Inicio post check de url"
        name = ''
        url = post_video_to_wistia(name, horse_params[:video])
        if url == "Excedio el limite de videos"
          puts "--------------------ERRROR----------------"
          puts "Excedio el limite de videos"
          @section_title = "Editar caballo"
          @horse = Horse.find(params[:id])
          flash.now[:alert] = "No se pudo editar el caballo, el almacenamiento de videos esta lleno"
          render :edit, status: :unprocessable_entity
        else
          @horse.video = url
          if @horse.save
            if @horse.update(horse_params.reject { |key, _| key == "video" || key == "photos" })
              redirect_to horse_show_path(@horse), notice: "Caballo editado con éxito"
            else
              @section_title = "Editar caballo"
              @horse = Horse.find(params[:id])
              flash.now[:alert] = "No se pudo editar el caballo, intente nuevamente"
              render :edit, status: :unprocessable_entity
            end
          else
            @section_title = "Editar caballo"
            @horse = Horse.find(params[:id])
            flash.now[:alert] = "No se pudo editar el caballo, intente nuevamente"
            render :edit, status: :unprocessable_entity
          end
        end
      else
        @section_title = "Editar caballo"
        @horse = Horse.find(params[:id])
        render :edit, status: :unprocessable_entity, alert: "Por favor cargue un video con formato válido"
      end
    else
      # If no video is uploaded
      if @horse.update(horse_params.reject { |key, _| key == "video" || key == "photos" })
        redirect_to horse_show_path(@horse)
      else
        @section_title = "Editar caballo"
        @horse = Horse.find(params[:id])
        render :edit, status: :unprocessable_entity, alert: "No se pudo editar el caballo, intente nuevamente"
      end
    end
  end

  def filtros
    @filtro = Filtro.new
    @horses = Horse.all.where.not(user_id: current_user.id)
    @jinetes = @horses.map { |horse| horse.rider }.uniq
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
      redirect_to profile_publication_caballos_path, notice: "Se elimino correctamente la publicacion"
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
      # 'access_token' => "596f97ec721a7997a641b5bd4c64f4e1f838d99e34d2dca91c8ccd46d1c18c8a",
      'access_token' => "f1e7de6e254c1d532ba7586cafc33e27267c9cafb8b134834b7870c08d6c93b7",
      'file' => UploadIO.new(
                  File.open(path_to_video),
                  'application/octet-stream',
                  File.basename(path_to_video)
                )
    }
    # Make it so!
    response = http.request(request)
    if response.code == "401"
      puts "Excedio el limite de videos"
      return "Excedio el limite de videos"
    else
      id = JSON.parse(response.body)["thumbnail"]["url"]
      id = id.split('/').last.split('.').first
      url = "http://embed.wistia.com/deliveries/#{id}.bin"
      return url
    end
  end

  def delete_video
    @horse = Horse.find(params[:id])
    @horse.video.purge
    redirect_to edit_horse_path(@horse), notice: "Video eliminado exitosamente."
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:rider, :name, :description, :birthday, :age, :height, :gender, :alzada, :pedigree, :pedigree_type, :food_photo, :video, photos: [])
  end
end
