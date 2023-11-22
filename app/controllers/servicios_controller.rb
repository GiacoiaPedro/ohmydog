class ServiciosController < ApplicationController


    def guardar_cuidador
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
          tipo: "1"  # Asignar "1" para indicar que es un cuidador
        )
      
        # Guardar el objeto en la base de datos
        if servicio.save
          redirect_to root_path  # Puedes redirigir a donde desees después de guardar
          flash[:success] = "Cuidador guardado exitosamente"
        else
          render :guardar_cuidador  # Volver a la vista del formulario con un mensaje de error
          flash[:error] = "Error al guardar el cuidador"
        end
      end
      
      def cuidadores
        @servicios = Servicio.all 
      end
      
      def paseadores
        @servicios = Servicio.all 
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
          tipo: "2"  # Asignar "2" para indicar que es un paseador
        )
      
        # Guardar el objeto en la base de datos
        if servicio.save
          redirect_to root_path  # Puedes redirigir a donde desees después de guardar
          flash[:success] = "Paseador guardado exitosamente"
        else
          render :guardar_cuidador  # Volver a la vista del formulario con un mensaje de error
          flash[:error] = "Error al guardar el Paseador"
        end
      end
      


end
