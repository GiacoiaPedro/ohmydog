class ServiciosController < ApplicationController
  before_action :set_servicio, only: [:edit, :actualizar_servicio]
  skip_before_action :verify_authenticity_token, only: :enviar_correo
  def guardar_cuidador
    nombre = params[:nombre]
    apellido = params[:apellido]
    zona = params[:zona]
    horarios = params[:horarios]
    dni = params[:dni]
    mail = params[:mail]

    servicio = Servicio.new(
      nombre: nombre,
      apellido: apellido,
      zona: zona,
      horarios: horarios,
      dni: dni,
      mail: mail,
      habilitado: 0,
      tipo: "1" 
    )
    if servicio.save
      flash[:success] = "Cuidador guardado exitosamente"
      redirect_to cuidadores_path
    else
      flash[:error] = "Error al guardar el cuidador"
      @errores = servicio.errors.full_messages
      render :cargar_cuidador
    end
  end

  def destroy
    @servicio = Servicio.find(params[:id])
    @servicio.update(habilitado: 1)
    redirect_to request.referer, notice: "Servicio eliminado exitosamente."
  end


  def cuidadores
    @servicios = Servicio.where(tipo: "1", habilitado: 0)
  end

  def paseadores
    @servicios = Servicio.where(tipo: "2", habilitado: 0)
  end

  def guardar_paseador
    # Recuperar los datos del formulario
    nombre = params[:nombre]
    apellido = params[:apellido]
    zona = params[:zona]
    horarios = params[:horarios]
    dni = params[:dni]
    mail = params[:mail]

    # Crear un nuevo objeto Servicio con los datos del formulario
    servicio = Servicio.new(
      nombre: nombre,
      apellido: apellido,
      zona: zona,
      horarios: horarios,
      dni: dni,
      mail: mail,
      habilitado: 0,
      tipo: "2"  # Asignar "2" para indicar que es un paseador
    )

    # Guardar el objeto en la base de datos
    if servicio.save
      flash[:success] = "Paseador guardado exitosamente"
      redirect_to paseadores_path
    else
      flash[:error] = "Error al guardar el Paseador"
      @errores = servicio.errors.full_messages
      render :cargar_paseador
    end
  end

  def enviar_correo
    @user_email = params['user-email']
    @paseador_email = params['paseador-email']
    @servicio_tipo = params['servicio-tipo']

    if @servicio_tipo == '1'
      UserMailer.contacto(@user_email, @paseador_email).deliver_now
    else @servicio_tipo == '2'
      UserMailer.contacto_paseador(@user_email, @paseador_email).deliver_now
    end

    
    redirect_back(fallback_location: root_path)
  end

  def actualizar_servicio
    # Validar la unicidad de DNI y correo electrónico solo si cambian
    if @servicio.dni != servicio_params[:dni] && Servicio.exists?(dni: servicio_params[:dni], tipo: @servicio.tipo, habilitado: 0)
      @servicio.errors.add(:dni, "ya está registrado como paseador") if @servicio.tipo == "2"
      @servicio.errors.add(:dni, "ya está registrado como cuidador") if @servicio.tipo == "1"
    end
  
    if @servicio.mail != servicio_params[:mail] && Servicio.exists?(mail: servicio_params[:mail], tipo: @servicio.tipo, habilitado: 0)
      @servicio.errors.add(:mail, "ya está registrado como paseador") if @servicio.tipo == "2"
      @servicio.errors.add(:mail, "ya está registrado como cuidador") if @servicio.tipo == "1"
    end
  
    if @servicio.errors.empty? && @servicio.update(servicio_params)
      flash[:success] = "Servicio actualizado exitosamente"
      if (@servicio.tipo == "2")
        redirect_to paseadores_path
      else
        redirect_to cuidadores_path
      end
    else
      flash[:error] = "Error al actualizar el servicio"
      render :edit
    end
  end

  private

  def servicio_params
    params.require(:servicio).permit(:nombre, :apellido, :dni, :zona, :mail, :tipo, :horarios, :habilitado)
  end

  def set_servicio
    @servicio = Servicio.find(params[:id])
  end
end