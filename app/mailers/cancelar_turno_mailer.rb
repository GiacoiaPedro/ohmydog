class CancelarTurnoMailer < ApplicationMailer

    def cancelar
      @turno = params[:turno]
      @user = @turno.perro.user
      @username = @user.nombre
      @fecha = @turno.fecha
      
      mail to: @user.email
    end
  end
  