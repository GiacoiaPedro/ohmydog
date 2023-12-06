# app/controllers/cruza_controller.rb
class CruzaController < ApplicationController
    before_action :mis_perros_cruza, only: [:cruza]
    before_action :hay_perros_cruza, only: [:cruza]

    def comparar   
      @perros_compatibles = [] # Inicializa la variable de instancia
      perro_seleccionado = Perro.find_by(id: params[:perro_id])
  
      if perro_seleccionado.present?
        
        # Obtén los perros compatibles (sexo opuesto y misma raza)
        perros_compatibles = Perro.where("id != ? AND sexo != ? AND raza_id = ? AND castrado = false AND user_id != ?", perro_seleccionado.id, perro_seleccionado.sexo, perro_seleccionado.raza_id, perro_seleccionado.user_id)
  
        if perros_compatibles.present?
          # Almacena los perros compatibles en la variable de instancia
          @perros_compatibles = perros_compatibles
        else
          flash[:alert] = 'No hay perros compatibles para la cruza.'
        end
      else
        flash[:error] = 'Perro no encontrado'
      end
    end
  
    def publicar
        perro_id = params[:perro_id]
      
        if perro_id.present?
          perro = Perro.find(perro_id)
      
          # Desactiva temporalmente las validaciones
          Perro.skip_callback(:validation, :before, :nombre_unico_por_usuario)
      
          # Actualiza el atributo cruza sin preocuparte por la validación de nombre único
          perro.update(cruza: true)
      
          # Vuelve a activar las validaciones
          Perro.set_callback(:validation, :before, :nombre_unico_por_usuario)
      
          flash[:notice] = "El perro ha sido publicado exitosamente para cruza."
          redirect_to cruza_path
        else
          flash[:alert] = "Selecciona un perro para publicar."
          redirect_to cruza_path
        end
      end
  
      def hay_perros_cruza
        @hay_perros_cruza = Perro.where(user_id: current_user.id)
      end


      def mis_perros_cruza
        @mis_perros_cruza = Perro.where(user_id: current_user.id, cruza: false)
      end
  end
  