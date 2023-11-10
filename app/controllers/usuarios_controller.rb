class UsuariosController < ApplicationController
#GET /usuarios
def index 
  @usuarios = Usuario.all 
end

#GET /usuarios/new
def new 
  @usuario = Usuario.new
end

def show
  @usuario = Usuario.find(params[:id])
end

#POST /usuarios
def create
  @usuario = Usuario.new(usuario_params)

  if @usuario.save
    flash[:success] = 'Usuario registrado exitosamente.'
    redirect_to root_path
  else
    render 'new'
  end
end

private

def usuario_params
  params.require(:usuario).permit(:dni, :nombre, :apellido, :rol_id)
end
end
