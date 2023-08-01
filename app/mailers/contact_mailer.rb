class ContactMailer < ApplicationMailer
  default to: 'ram6494@psu.edu' # Replace with your email address (website owner's email)

  def send_contact_message(message)
    @user_message = message
    mail(subject: 'User Inquiry')
  end
end
