class CruzaContactoMailer < ApplicationMailer
    def contactar_duenio(duenio, perro, user)
      @duenio = duenio
      @perro = perro
      @user = user
      mail(to: @duenio.email, subject: '¡Alguien quiere contactar para la cruza de tu perro!')
    end
  end