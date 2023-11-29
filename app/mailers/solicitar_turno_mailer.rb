class SolicitarTurnoMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.solicitar_turno_mailer.confirm.subject
  #
  def confirm
    @turno = params[:turno]
    @user = @turno.perro.user
    @username = @user.nombre
    @fecha = @turno.fecha
    
    mail to: @user.email
  end
end
