class ContactController < ApplicationController
  def index
    @section_title = "Ayuda"
    @help = Help.new
  end

  def send_message
    @help = Help.create(help_params)
    @help.user = current_user
    if @help.save
      redirect_to contact_path(mensaje_enviado: 'ok')
    else
      redirect_to contact_path, alert: "No se pudo enviar el mensaje, intente nuevamente"
    end
      # user_message = params[:message]
      # ContactMailer.send_contact_message(user_message).deliver_now
  end

  def help_params
    params.require(:help).permit(:message)
  end
end
