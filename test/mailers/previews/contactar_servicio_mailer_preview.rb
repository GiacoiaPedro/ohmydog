# Preview all emails at http://localhost:3000/rails/mailers/contactar_servicio_mailer
class ContactarServicioMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contactar_servicio_mailer/contactar
  def contactar
    ContactarServicioMailer.contactar
  end

end
