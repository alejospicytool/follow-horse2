class RegistrationsController < Devise::RegistrationsController
  
  before_action :set_user, only: %i[edit]
  
  def new
    @user = User.new()
    country_code_array = JSON.parse(File.read('app/assets/country_codes.json'))['countries']
    @country_codes = {}
    country_code_array.map{ |country| @country_codes["#{country['name']} (#{country['code']})"] = "#{country['name']} (#{country['code']})" }
  end

  def edit
    super
  end

  protected

  def after_sign_up_path_for(*)
    flash[:notice] = 'Te has registrado exitosamente'
    registro_gracias_path
  end

  def after_update_path_for(resource)
    flash[:notice] = "Datos actualizados correctamente"
    edit_user_registration_path
  end

  def update_resource(resource, params)
    if params[:password].present?
      resource.update_with_password(params)
    else
      params.delete(:current_password)  # Remove current_password as it's not an attribute
      resource.update_without_password(params)
    end
  end
  
  ## def configure_permitted_parameters
  ##   devise_parameter_sanitizer.permit(:sign_up, keys: [:nombre, :apellido, :age, :establishment, :direccion, :provincia, :ciudad, :pais, :email, :password, :password_confirmation, :phone, :country_code])
  ## end

  ## def account_update_params
  ##   params.require(:user).permit(:age, :establishment, :phone, :direccion, :ciudad, :provincia, :pais, :description, :password, :password_confirmation, :photo)
  ## end
  
  def set_user
    puts 'ENTREEEEEEE'
    puts current_user.inspect
    puts ''
    @user = User.find(current_user.id)
    country_code_array = JSON.parse(File.read('app/assets/country_codes.json'))['countries']
    @country_codes = {}
    country_code_array.map{ |country| @country_codes["#{country['name']} (#{country['code']})"] = "#{country['name']} (#{country['code']})" }
  end

end
