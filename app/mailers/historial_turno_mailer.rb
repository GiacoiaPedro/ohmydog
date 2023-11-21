class HistorialTurnoMailer < ApplicationMailer
    def new_historial_turno(historial_turno)
        @turno = historial_turno
        @user = historial_turno.perro.user
        mail(to: @user.email, subject: 'Turno solicitado')
    end
end
