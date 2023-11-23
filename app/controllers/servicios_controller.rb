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
          flash[:success] = "Cuidador guardado exitosamente"
          redirect_to cuidadores_path
        else
          flash[:error] = "Error al guardar el cuidador"
          render :guardar_cuidador
        end
      end
      
      def cuidadores
        @servicios = Servicio.where(tipo: "1")
      end
      
      def paseadores
        @servicios = Servicio.where(tipo: "2")
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
          flash[:success] = "Paseador guardado exitosamente"
          redirect_to paseadores_path
        else
          flash[:error] = "Error al guardar el Paseador"
          render :guardar_paseador
        end
      end
      


end
