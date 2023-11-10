class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :update_allowed_parameters, if: :devise_controller?
  
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:email, :password, :password_confirmation, :rol_id, :dni, :nombre, :apellido, :fecha_nacimiento, :mail, :telefono)
      end
    end
  end
  