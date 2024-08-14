class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :count_conversations

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :nombre, :apellido, :description, :age, :photo, :remember_me, :phone, :pais, :provincia, :ciudad, :direccion, :establishment, :country_code])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [ :nombre, :apellido, :description, :age, :photo, :remember_me, :phone, :pais, :provincia, :ciudad, :direccion, :establishment, :country_code ])

    @disable_nav = true
  end

  def after_sign_in_path_for(*)
    home_path
  end

  def after_sign_out_path_for(*)
    new_user_session_path
  end

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end

  def favorite_horse_text(horse)
    @favorite_exists = Favorite.where(horse: horse, user: current_user) != []
    return @favorite_exists ? "fav" : "nofav"
  end

  def favorite_auction_text(auction)
    @favorite_exists = Favorite.where(auction: auction, user: current_user) != []
    return @favorite_exists ? "fav" : "nofav"
  end

  def set_locale
    I18n.locale = :es
  end

  def count_conversations
    
    if current_user
      conv1 = Conversation.where(sender_id: current_user.id).where(archive: false)
      conv2 = Conversation.where(recipient_id: current_user.id).where(archive: false)
      conversations = conv1 + conv2
      @total_msgs = 0
      conversations.each do |conversation|
        @total_msgs += conversation.messages.where(read: false).where.not(user_id: current_user.id).length
      end
    end
    
  end

  helper_method :favorite_horse_text, :favorite_auction_text
end
