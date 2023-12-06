# Preview all emails at http://localhost:3000/rails/mailers/solicitar_turno_mailer
class SolicitarTurnoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/solicitar_turno_mailer/confirm
  def confirm
    SolicitarTurnoMailer.confirm
  end

end
