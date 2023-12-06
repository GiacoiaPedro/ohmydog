# Preview all emails at http://localhost:3000/rails/mailers/cancelar_turno_mailer
class CancelarTurnoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/cancelar_turno_mailer/cancelar
  def cancelar
    CancelarTurnoMailer.cancelar
  end

end
