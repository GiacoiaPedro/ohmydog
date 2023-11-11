# frozen_string_literal: true


  class Users::RegistrationsController < Devise::RegistrationsController
    skip_before_action :require_no_authentication, only: [:new, :create]
    before_action :authenticate_user!

    def edit_password
      @user = current_user
      render :edit_password
    end

  
    def update_password
      @user = current_user
      if current_user.update_with_password(password_params)
        bypass_sign_in(current_user)
        redirect_to root_path, notice: 'Contraseña actualizada con éxito.'
      else
        render 'edit_password'
        
      end
    end
    def create
      build_resource(sign_up_params)
  
      resource.save
      yield resource if block_given?
      if resource.persisted?
        set_flash_message! :notice, :signed_up
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end



    private

    def update_resource(resource, params)
    resource.update_with_password(params)
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
    end
  
    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
  end
