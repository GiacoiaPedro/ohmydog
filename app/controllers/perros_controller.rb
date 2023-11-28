class PerrosController < ApplicationController

  def new
    @perro = Perro.new
    @razas = Raza.all || [] 
    Rails.logger.debug(@razas.inspect)  # verifica los valores de Raza
    render 'registrar_perro'
  end
  
  def create
    @perro = Perro.new(perro_parametros)
  
    # Buscar el usuario por DNI
    if params[:perro] && params[:perro][:dueño_dni]
      usuario = User.find_by(dni: params[:perro][:dueño_dni])
  
      if usuario
        # Asignar el id del usuario encontrado al user_id del perro
        @perro.user_id = usuario.id
  
        if @perro.save
          redirect_to root_path, notice: 'El perro ha sido registrado exitosamente.'
        else
          render 'registrar_perro'
        end
      else
        # Manejar el caso en que el usuario no fue encontrado
        @perro.errors.add(:dueño_dni, "No se encontró un usuario con este DNI")
        render 'registrar_perro'
      end
    else
      # Manejar el caso en que el parámetro dueño_dni no está presente
      @perro.errors.add(:dueño_dni, "Parámetro dueño_dni no presente en la solicitud")
      render 'registrar_perro'
    end
  end
  
  def mis_perros
    @mis_perros = Perro.where(user_id: current_user.id)
    @razas = Raza.all

  end

# perros_controller.rb
def edit
  @perro = Perro.find(params[:id])
end


def update
  @perro = Perro.find(params[:id])
  
  # Aplicar downcase al nombre antes de actualizar el perro
  params[:perro][:nombre] = params[:perro][:nombre].downcase if params[:perro][:nombre].present?

  if @perro.update(perro_params)
    redirect_to mis_perros_path, notice: 'Modificación exitosa.'
  else
    # Si la actualización falla debido a la validación del nombre único,
    # redireccionar con el mensaje personalizado.
    if @perro.errors[:nombre].include?('ya está en uso para este usuario')
      redirect_to mis_perros_path, notice: 'Ya existe un perro con ese nombre.'
    else
      @mis_perros = Perro.where(user_id: current_user.id)
      @razas = Raza.all
      render 'mis_perros'
    end
  end
end






  private

  def perro_params
    params.require(:perro).permit(:nombre, :fecha_nacimiento, :sexo, :raza_id)
  end


  def perro_parametros
    params.require(:perro).permit(:nombre, :edad, :fecha_nacimiento, :sexo, :user_id, :raza_id, :dueño_dni)
  end
  
end
  

