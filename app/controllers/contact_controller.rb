class ContactController < ApplicationController
  def index
  end

  def send_message
    user_message = params[:message]
    ContactMailer.send_contact_message(user_message).deliver_now
    redirect_to home_path, notice: "Your message has been sent. Thank you!"
  end
end
