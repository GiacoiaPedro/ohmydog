class DashboardController < ApplicationController
  def index
  end

  def eliminar_usuario
    # Lógica para eliminar usuarios si es necesario
    # ...

    # Obtén la lista de usuarios habilitados
    @usuarios = User.where(habilitado: true)
  end

  # app/controllers/usuarios_controller.rb

def eliminar
  @usuario = User.find(params[:id])
  @usuario.update(habilitado: false)
  redirect_to root_path, notice: 'Usuario deshabilitado exitosamente.'
end

def registrar_perro
  dni = params[:dni_dueño] 
  @user = User.find_by(dni: dni)

  if @user
    @perro = Perro.new
    @perro.user = @user
  else
    flash[:alert] = 'User not found with the provided DNI'
    redirect_to root_path
  end
end

end
