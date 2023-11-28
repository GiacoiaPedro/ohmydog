class UserMailer < ApplicationMailer

  default from: "no-reply@ohmydog.com"
  layout nil
  def bienvenida
    @user = params[:user]
    @password = params[:password]
    @username = @user.nombre
    mail(to: @user.email, subject: '¡Bienvenido a OhMyDog!')
  end

  def contacto(user_email, paseador_email)
    @user_email = user_email
    @paseador_email = paseador_email

    mail(to: @paseador_email, subject: '¡Un usuario está interesado en tus servicios!')
  end


end