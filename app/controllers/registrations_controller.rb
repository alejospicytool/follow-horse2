class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(*)
    flash[:notice] = 'Te has registrado exitosamente'
    registro_gracias_path
  end

end
