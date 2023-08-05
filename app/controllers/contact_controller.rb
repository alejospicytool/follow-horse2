class ContactController < ApplicationController
  def index
    @section_title = "Ayuda"
  end

  def send_message
    user_message = params[:message]
    ContactMailer.send_contact_message(user_message).deliver_now
    redirect_to contact_path(mensaje_enviado: 'ok')
  end
end
