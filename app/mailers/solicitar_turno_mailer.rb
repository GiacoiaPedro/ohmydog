class SolicitarTurnoMailer < ApplicationMailer


  def confirm
    @turno = params[:turno]
    @user = @turno.perro.user
    @username = @user.nombre
    @fecha = @turno.fecha
    
    mail to: @user.email
  end
end
