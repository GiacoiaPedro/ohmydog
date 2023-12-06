# Preview all emails at http://localhost:3000/rails/mailers/agregar_horario_mailer
class AgregarHorarioMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/agregar_horario_mailer/agregar
  def agregar
    AgregarHorarioMailer.agregar
  end

end
