class PerrosController < ApplicationController

  def new
    @perro = Perro.new
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
  

  private

  def perro_parametros
    params.require(:perro).permit(:nombre, :edad, :fecha_nacimiento, :sexo, :user_id, :dueño_dni)
  end
  
end
