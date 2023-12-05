# app/controllers/perros_perdidos_controller.rb
class PerrosPerdidosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit]
  protect_from_forgery with: :exception

  def index
    @perros_perdido = PerroPerdido.where(activa: true, tipo: 1) 
  end

  def new
    @perro_perdido = PerroPerdido.new
  end

  def mis_publicaciones
    @perros_perdido = PerroPerdido.where(user_id: current_user.id, tipo: 1)
    render 'index'
  end

  def filtrar
    @perros_perdido = PerroPerdido.where(raza_id: params[:filter_raza], activa: true, tipo: 1) if params[:filter_raza].present?
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
  
  def contactar_propietario
    # Your logic for contacting the owner goes here
    # You may render a separate view for contacting the owner
    render 'contactar_propietario'
  end


  def edit
    @perro_perdido = PerroPerdido.find(params[:id])
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
    puts "Tipo valor: #{params[:perro_perdido][:tipo]}" # Agrega esta línea


    if @perro_perdido.save
      redirect_to perros_perdidos_path, notice: 'La publicación de perro perdido fue creada exitosamente.'
    else
      render :new
    end
  end


  def enviar_correo_perro_encontrado
    # Lógica para enviar el correo desde 'ohmydog' a la dirección almacenada en la base de datos
    # Utiliza la gema de envío de correo que prefieras (por ejemplo, ActionMailer)
    # ...

    redirect_to perros_perdidos_path, notice: 'Correo enviado con éxito'
  end
  
  
  

  private

  def perro_perdido_params
    params.require(:perro_perdido).permit(:nombre, :sexo, :raza_id, :comportamiento, :lugar, :fecha, :foto, :edad, :mail, :tipo)
  end
end