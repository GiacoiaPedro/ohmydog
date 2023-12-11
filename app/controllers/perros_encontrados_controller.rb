class PerrosEncontradosController < ApplicationController
    def index
        @perros_perdido = PerroPerdido.where(activa: true, tipo: 2) 
      end
      
      def new
        @perro_perdido = PerroPerdido.new
      end
    
      def mis_publicaciones
        @perros_perdido = PerroPerdido.where(user_id: current_user.id, tipo: 2)
        render 'index'
      end
    
      def mark_found
        @perro_perdido = PerroPerdido.find(params[:id])
        @perro_perdido.update(encontrado: true)
        redirect_to perros_encontrados_path, notice: 'Perro marcado como encontrado.'
      end
    
    
      def update
        @perro_perdido = PerroPerdido.find(params[:id])
      
        if @perro_perdido.update(perro_perdido_params)
          redirect_to perros_encontrados_path, notice: 'Publicación actualizada exitosamente.'
        else
          render :edit
        end
      end
      
    
    
      def edit
        @perro_perdido = PerroPerdido.find(params[:id])
      end
      
    
      def destroy
        @perro_perdido = PerroPerdido.find(params[:id])
      
        if @perro_perdido
          @perro_perdido.update(activa: false)
          redirect_to perros_encontrados_path, notice: 'Publicación eliminada exitosamente.'
        else
          redirect_to perros_encontrados_path, alert: 'No se pudo encontrar la publicación.'
        end
      end
      
    
      def create
        @perro_perdido = PerroPerdido.new(perro_perdido_params)
        @perro_perdido.user_id = current_user.id
        puts "Tipo valor: #{params[:perro_perdido][:tipo]}" # Agrega esta línea
    
    
        if @perro_perdido.save
          redirect_to perros_encontrados_path, notice: 'La publicación de perro encontrado fue creada exitosamente.'
        else
          render :new
        end
      end
    
      def contactar_propietario_encontrado
        @perro_perdido = PerroPerdido.find(params[:id])
      
        render 'contactar_propietario'
      end
      
    
      def enviar_correo_encontrado
        perro_perdido = PerroPerdido.find(params[:perro_id])
        correo_contacto = params[:correo]
        nombre = params[:nombre] 
        telefono = params[:telefono]  
      
        UserMailer.contactar_propietario_encontrado(perro_perdido, correo_contacto, nombre, telefono).deliver_now
      
        redirect_to perros_encontrados_path, notice: 'Correo enviado con éxito. La persona se contactará contigo via mail.'
      end

      def filtrar
        @perros_perdido = PerroPerdido.where(raza_id: params[:filter_raza], activa: true, tipo: 2) if params[:filter_raza].present?
        render 'index'
      end
      
      
      
    
      private
    
      def perro_perdido_params
        params.require(:perro_perdido).permit(:nombre, :sexo, :raza_id, :comportamiento, :lugar, :fecha, :foto, :edad, :mail, :tipo)
      end
    end