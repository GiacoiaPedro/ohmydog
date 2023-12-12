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

    mail(to: @paseador_email, subject: '¡Un usuario está interesado en tus servicios de cuidador!')
  end

  def contacto_paseador(user_email, paseador_email)
    @user_email = user_email
    @paseador_email = paseador_email

    mail(to: @paseador_email, subject: '¡Un usuario está interesado en tus servicios de paseador!')
  end

  def contactar_propietario_perdido(perro_perdido, correo_contacto, nombre, telefono)
    @perro_perdido = perro_perdido
    @correo_contacto = correo_contacto
    @nombre = nombre
    @telefono = telefono
  
    mail(to: @perro_perdido.mail, subject: '¡Alguien encontró el perro que publicaste!')
  end

  def contactar_propietario_encontrado(perro_perdido, correo_contacto, nombre, telefono)
    @perro_perdido = perro_perdido
    @correo_contacto = correo_contacto
    @nombre = nombre
    @telefono = telefono
  
    mail(to: @perro_perdido.mail, subject: '¡Encontramos al dueño del perro que publicaste!')
  end


end