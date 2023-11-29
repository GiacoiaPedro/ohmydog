class CambiarFechaMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cambiar_fecha_mailer.cambiar.subject
  #
  def cambiar
    @turno = params[:turno]
    @user = @turno.perro.user
    @username = @user.nombre
    @fecha = @turno.fecha
    @texto = @turno.texto
    
    mail to: @user.email
  end
end
