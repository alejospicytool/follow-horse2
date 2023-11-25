class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(*)
    flash[:notice] = 'Te has registrado exitosamente'
    registro_gracias_path
  end

  def after_update_path_for(resource)
    flash[:notice] = "Datos actualizados correctamente"
    edit_user_registration_path
  end

  protected

  def update_resource(resource, params)
    if params[:password].present?
      resource.update_with_password(params)
    else
      params.delete(:current_password)  # Remove current_password as it's not an attribute
      resource.update_without_password(params)
    end
  end
  
  
  def account_update_params
    params.require(:user).permit(:age, :establishment, :phone, :direccion, :ciudad, :provincia, :pais, :description, :password, :password_confirmation, :photo)
  end
  
  

end
