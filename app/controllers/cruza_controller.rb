# app/controllers/cruza_controller.rb
class CruzaController < ApplicationController
  before_action :mis_perros_cruza, only: [:cruza]
  before_action :mis_perros_cruzados, only: [:cruza]

  def publicar
    @perro_id = params[:perro_id]
    if @perro_id.present?
      perro = Perro.find(@perro_id)
      if perro.cruza == false
        perro.update(cruza: true)
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


  def destroy_perro_cruza
    @perro_id = params[:id]
    if @perro_id.present?
      perro = Perro.find(@perro_id)
      perro.update(cruza: false)
    end
    redirect_to cruza_path
  end

  def destroy
    @perro_id = params[:id]
    if @perro_id.present?
      perro = Perro.find(@perro_id)
      perro.update(cruza: false)
    end
    redirect_to cruza_path
  end

  def contactar
    @perro = Perro.find(params[:id])
    @duenio = User.find(@perro.user_id)
    @user = current_user
  
    CruzaContactoMailer.contactar_duenio(@duenio, @perro, @user).deliver_now
  
    flash[:success] = 'Correo electrónico de contacto enviado al dueño del perro.'
    redirect_to publicar_path(perro_id: params[:perro_id])
  end

  def mis_perros_cruzados
    @mis_perros_cruzados = Perro.where(user_id: current_user.id, cruza: true)
  end

  def mis_perros_cruza
    @mis_perros_cruza = Perro.where(user_id: current_user.id, castrado: false)
  end

  def eliminar_perro
    @mis_perros_cruzados = Perro.where(user_id: current_user.id, cruza: true)
  end

end
