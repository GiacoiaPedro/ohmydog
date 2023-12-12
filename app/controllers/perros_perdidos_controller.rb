# app/controllers/perros_perdidos_controller.rb
class PerrosPerdidosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit]
  protect_from_forgery with: :exception

  def index
    @perros_perdido = PerroPerdido.where(activa: true, tipo: 1) 
  end

  def new
    @user_perros = current_user.perros
    @perro_details = @user_perros.each_with_object({}) do |perro, details|
      details[perro.id] = { nombre: perro.nombre, raza_id: perro.raza_id, sexo: perro.sexo, fecha_nacimiento: perro.fecha_nacimiento, edad: ((Date.today - perro.fecha_nacimiento) / 30).to_i }
    end
    @perro_perdido = PerroPerdido.new
  end

  def mis_publicaciones
    @perros_perdido = PerroPerdido.where(user_id: current_user.id, tipo: 1)
    render 'index'
  end

  def filtrar
    if params[:filter_raza].present?
      @perros_perdido = PerroPerdido.where(raza_id: params[:filter_raza], activa: true, tipo: 1)
    else
      @perros_perdido = PerroPerdido.where(activa: true, tipo: 1)
    end
    render 'index'
  end

  def mark_found
    @perro_perdido = PerroPerdido.find(params[:id])
    @perro_perdido.update(encontrado: true)
    redirect_to perros_perdidos_path, notice: 'Perro marcado como encontrado.'
  end

  def update
    @perro_perdido = PerroPerdido.find(params[:id])

    if @perro_perdido.update(perro_perdido_params)
      redirect_to perros_perdidos_path, notice: 'Publicación actualizada exitosamente.'
    else
      render :edit
    end
  end

  def edit
    @perro_perdido = PerroPerdido.find(params[:id])
  end

  def contactar_propietario
    @perro_perdido = PerroPerdido.find(params[:id])

    render 'contactar_propietario'
  end

  def enviar_correo_perdido
    perro_perdido = PerroPerdido.find(params[:perro_id])
    correo_contacto = params[:correo]
    nombre = params[:nombre]
    telefono = params[:telefono]
  
    UserMailer.contactar_propietario_perdido(perro_perdido, correo_contacto, nombre, telefono).deliver_now
  
    redirect_to perros_perdidos_path, notice: 'Correo enviado con éxito. El dueño se contactará contigo vía mail.'
  end
  

  def destroy
    @perro_perdido = PerroPerdido.find(params[:id])

    if @perro_perdido
      @perro_perdido.update(activa: false)
      redirect_to perros_perdidos_path, notice: 'Publicación eliminada exitosamente.'
    else
      redirect_to perros_perdidos_path, alert: 'No se pudo encontrar la publicación.'
    end
  end

  def create
    @perro_perdido = PerroPerdido.new(perro_perdido_params)
    @perro_perdido.user_id = current_user.id
  
    # Calcular la edad en meses
    if @perro_perdido.fecha_nacimiento.present?
      @perro_perdido.edad = ((Date.today - @perro_perdido.fecha_nacimiento) / 30).to_i
    end
  
    if @perro_perdido.save
      redirect_to perros_perdidos_path, notice: 'La publicación de perro perdido fue creada exitosamente.'
    else
      render :new
    end
  end
  

  private

  def perro_perdido_params
    params.require(:perro_perdido).permit(:nombre, :sexo, :raza_id, :comportamiento, :lugar, :fecha, :foto, :edad, :mail, :tipo, :fecha_nacimiento)
  end
end
