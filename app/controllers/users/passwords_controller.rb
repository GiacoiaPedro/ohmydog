class Users::PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.find_by_email(resource_params[:email])

    if resource
      # Generar automáticamente una nueva contraseña
      new_password = generate_random_password

      # Actualizar la contraseña del usuario
      resource.update(password: new_password, password_confirmation: new_password)

      # Enviar un correo electrónico con la nueva contraseña
      UserMailer.with(user: resource, password: new_password).reset_password.deliver_later

      set_flash_message! :notice, :send_instructions
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      set_flash_message! :alert, :email_not_found
      respond_with({}, location: new_password_path(resource_name))
    end
  end
end