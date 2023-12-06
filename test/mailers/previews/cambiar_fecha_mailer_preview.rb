# Preview all emails at http://localhost:3000/rails/mailers/cambiar_fecha_mailer
class CambiarFechaMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/cambiar_fecha_mailer/cambiar
  def cambiar
    CambiarFechaMailer.cambiar
  end

end
