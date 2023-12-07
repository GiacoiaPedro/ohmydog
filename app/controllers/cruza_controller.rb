# app/controllers/cruza_controller.rb
class CruzaController < ApplicationController
  before_action :mis_perros_cruza, only: [:cruza]

  def publicar
    @perro_id = params[:perro_id]
    puts "perro_id: #{@perro_id}"
    if @perro_id.present?
      perro = Perro.find(@perro_id)
      puts "perro: #{perro.inspect}"
      if perro.cruza == false
        Perro.skip_callback(:validation, :before, :nombre_unico_por_usuario)
        perro.update(cruza: true)
        Perro.set_callback(:validation, :before, :nombre_unico_por_usuario)
      end
    end

    if @perro_id.present?
      @perro = Perro.find(@perro_id)
      opuesto_sexo = @perro.sexo == "Macho" ? "Hembra" : "Macho"
      @perros_compatibles = Perro.where.not(id: @perro.id)
                                 .where(cruza: true, castrado: false)
                                 .where(raza_id: @perro.raza_id)
                                 .where(sexo: opuesto_sexo)
                                 .where.not(user_id: current_user.id)
    end
  end

  def contactar
    @perro = Perro.find(params[:id])
    @duenio = User.find(@perro.user_id)
    @user = current_user
  
    CruzaContactoMailer.contactar_duenio(@duenio, @perro, @user).deliver_now
  
    flash[:success] = 'Correo electrónico de contacto enviado al dueño del perro.'
    redirect_to publicar_path(perro_id: params[:perro_id])
  end

  def mis_perros_cruza
    @mis_perros_cruza = Perro.where(user_id: current_user.id)
  end
end
