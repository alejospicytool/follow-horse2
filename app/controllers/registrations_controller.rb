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

  # def update_resource(resource, account_update_params)
  #   resource.update(account_update_params)
  #   after_update_path_for(resource)
  # end

  # def account_update_params
  #   params.require(:user).permit(:age, :establishment, :phone, :direccion, :ciudad, :provincia, :pais, :description, :password, :password_confirmation, :photo)
  # end

end
