class ContactarServicioMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contactar_servicio_mailer.contactar.subject
  #
  def contactar(user_email)
    @user = params[:user]
    @servicio = params[:servicio]
    @username = @user.nombre
    @user_email = user_email



    mail (to: @user.email ,subject: '¡Un usuario está interesado en tus servicios!')
  end
end
