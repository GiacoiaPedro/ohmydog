class AgregarHorarioMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.agregar_horario_mailer.agregar.subject
  #
  def agregar
    @turno = params[:turno]
    @user = @turno.perro.user
    @username = @user.nombre
    @fecha = @turno.fecha
    @hora = @turno.hora
    
    mail to: @user.email
  end
end
