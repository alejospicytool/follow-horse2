class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :nombre, :apellido, :description, :age, :photo, :remember_me, :phone, :pais, :provincia, :ciudad, :direccion, :establishment])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [ :nombre, :apellido, :description, :age, :photo, :remember_me, :phone, :pais, :provincia, :ciudad, :direccion, :establishment ])

    @disable_nav = true
  end

  def after_sign_in_path_for(*)
    home_path
  end

end
