# frozen_string_literal: true


  class Users::RegistrationsController < Devise::RegistrationsController

    require 'securerandom'

    skip_before_action :require_no_authentication, only: [:new, :create]
    before_action :authenticate_user!

    def edit_password
      @user = current_user
      render :edit_password
    end

    def update
      @user = current_user
      if @user.update_with_password(account_update_params)
        bypass_sign_in(@user)
        redirect_to root_path, notice: 'Perfil actualizado con éxito.'
      else
        render 'edit'
      end
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
      existing_user = User.find_by(dni: sign_up_params[:dni])
  
      if existing_user
        flash[:alert] = 'El DNI ya está registrado.'
        redirect_back fallback_location: root_path
      else
        build_resource(sign_up_params)
  
        generated_password = generate_random_password
        resource.password = generated_password
        resource.password_confirmation = generated_password
  
        if resource.save
          bypass_sign_in(resource)
          set_flash_message! :notice, :signed_up
          clean_up_passwords resource
          set_minimum_password_length
  
          # Redirige a la ruta raíz después de la creación del usuario
          redirect_to root_path
  
          UserMailer.with(user: resource, password: generated_password).bienvenida.deliver_later
        else
          clean_up_passwords resource
          set_minimum_password_length
          respond_with resource
        end
      end
    end
  
  
    
        protected
    
        def after_sign_in_path_for(resource)
          # Personaliza esta ruta según tus necesidades
          root_path
        end
  
    private
  
    def generate_random_password(length = 12)
      SecureRandom.urlsafe_base64(length).tr('lIO0', 'sxyz')
    end

    def update_resource(resource, params)
    resource.update_with_password(params)
    end

    def account_update_params
      params.require(:user).permit(:email, :nombre, :apellido, :telefono, :fecha_nacimiento, :current_password)
    end
    
  
    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
  end

