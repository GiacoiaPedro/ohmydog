class UserMailer < ApplicationMailer
  def bienvenida
    @user = params[:user]
    @password = params[:password]
    @username = @user.nombre
    mail(to: @user.email, subject: '¡Bienvenido a OhMyDog!')
  end
  
end
