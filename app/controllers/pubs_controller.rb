require 'cloudinary'

class PubsController < ApplicationController

    def index
        
        @pub_imgs = Pub.all.where(asset_type: "photo")

        @pub_video = Pub.all.where(asset_type: "video")
        
        @new_pub = Pub.new
        
    end

    def create

        if params[:pub] && params[:pub][:photos]
            
            success, msg = add_pub_imgs(params[:pub][:photos])

            if success
                redirect_to pubs_path, success: msg
            else
                redirect_to pubs_path, alert: msg
            end
            
        elsif params[:pub] && params[:pub][:video]
            
            success, msg = add_pub_video(params[:pub][:video])

            if success
                redirect_to pubs_path, success: msg
            else
                redirect_to pubs_path, alert: msg
            end
            
        else
            redirect_to pubs_path, alert: 'Ocurrio un error al intentar subir el archivo. Asegurese de haber cargado al menos un archivo y en el formato correcto.'
        end
        

    end
    
    def add_pub_imgs(images)

        ## Correction is due to the first element to be empty
        total_images = images.length - 1
        images_counter = 0
        msg = ""
        images.each do |image|
            if image != ""
                @pub = Pub.create(pub_params)
                @pub.asset_type = 'photo'
                begin
                    img_result = Cloudinary::Uploader.upload(image)
                    @pub.url = img_result["secure_url"]
                rescue Exception => e
                    puts '======='
                    puts e
                    puts '======='
                    msg += "No se pudo subir el archivo #{image.original_filename}\n"
                else
                    if @pub.save
                        images_counter += 1
                        msg += "El archivo #{image.original_filename} se guardó correctamente\n"
                    else
                        msg += "Se pudo subir el archivo #{image.original_filename}, pero no se pudo guardar el registro en la base de datos\n"
                    end
                end

            end
        end

        if images_counter >= total_images
            [true, msg]
        else
            [false, msg]
        end
        
    end
    
    def add_pub_video(video_path)
        
        Cloudinary.config_from_url("cloudinary://894899123771416:2-xujc6WZoT4bN3bUDOOtTv8YMM@dgmtchxjj")

        success = Cloudinary::Uploader.destroy("pub_video", resource_type: 'video')
        
        if success["reult"] == 'ok'
            puts "Video anterior eliminado correctamente"
        else
            puts "El video anterior no se pudo eliminar correctamente"
        end

        old_video_pubs = Pub.all.where(asset_type: "video")

        if old_video_pubs.length > 0 && old_video_pubs.destroy
            puts 'Publicaciones de video anteriores eliminadas correctamente'
        else
            puts 'No se pudieron eliminar los registros de video anteriores'
        end
        
        success, msg = post_video_to_cloudinary(video_path, "pub_video")
        
        [success, msg]

    end
    
    def post_video_to_cloudinary(path_to_video, video_name)
        
        begin
    
          uploaded_video_response = Cloudinary::Uploader.upload_large(
            path_to_video, 
            resource_type: "video",
            public_id: video_name,
            chunk_size: 6_000_000,
            eager: [
              {width: 300, height: 300, crop: "pad", audio_codec: "none"}, 
              {width: 160, height: 100, crop: "crop", gravity: "south", audio_codec: "none "}], 
            eager_async: true, 
            ## eager_notification_url: "http://mysite.example.com/notify_endpoint"
          )
    
        rescue Exception => e
    
          [false, e]
    
        else
          puts '================'
          puts ''
          puts uploaded_video_response.inspect
          puts ''
          puts '================'

          new_video_pub = Pub.create(
            url: uploaded_video_response["secure_url"],
            asset_type: "video"
          )

          if new_video_pub.save
            [true , "Video subido con éxito"]
          else
            [false, "El video no pudo ser guardado en la base de datos"]
          end
    
        end
        
    end
    
    def delete_pub_img
        
        photo_to_delete = Pub.find(params["asset_id"])
        
        public_id = photo_to_delete[:url].split("/")[-1].split(".")[0]
        
        cl_response = Cloudinary::Uploader.destroy(public_id)

        if cl_response["result"] == "ok"
            puts 'Se pudo eliminar la imagen de Cloudinary correctamente'
        else
            puts "No se pudo eliminar la imagen de Cloudinary"
        end
        
        if photo_to_delete.destroy
          redirect_to pubs_path, success: "Se eliminó la publicación correctamente"
        else
          redirect_to pubs_path, alert: "No se pudo eliminar la publicación"
        end
    end

    def delete_pub_video
        
        video_to_delete = Pub.all.where(asset_type: "video")[0]
        
        public_id = video_to_delete[:url].split("/")[-1].split(".")[0]
        
        cl_response = Cloudinary::Uploader.destroy(public_id)

        if cl_response["result"] == "ok"
            puts 'Se pudo eliminar el video de Cloudinary correctamente'
        else
            puts "No se pudo eliminar el video de Cloudinary"
        end
        
        if video_to_delete.destroy
          redirect_to pubs_path, success: "Se eliminó la publicación correctamente"
        else
          redirect_to pubs_path, alert: "No se pudo eliminar la publicación"
        end
    end

    private

    def pub_params
        params.require(:pub).permit(:url, :asset_type)
    end
end