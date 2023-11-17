# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
    def create
      user = User.find_by(dni: params[:user][:dni])
  
      if user && user.valid_password?(params[:user][:password]) && user.habilitado?
        super
      else
        flash[:alert] = "Usuario no habilitado o credenciales incorrectas"
        redirect_to new_user_session_path
      end
    end

    def show 
        @user = User.find(params[:user][:id])
    end

end
  