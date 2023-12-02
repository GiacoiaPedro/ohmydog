# app/controllers/cruza_controller.rb
class CruzaController < ApplicationController
    before_action :mis_perros_cruza, only: [:cruza]
  
    def verificar_disponibilidad
      perro_seleccionado = Perro.find_by(id: params[:perro_id])
  
      if perro_seleccionado.present?
        perros_disponibles = Perro.where(
          sexo: (perro_seleccionado.sexo == 'macho' ? 'hembra' : 'macho'),
          raza_id: perro_seleccionado.raza_id,
          cruza: true
        ).where.not(user_id: current_user.id)
  
        @perros_disponibles_info = perros_disponibles.map do |perro|
          {
            nombre: perro.nombre,
            fecha_nacimiento: perro.fecha_nacimiento,
            sexo: perro.sexo,
            raza: perro.raza.nombre,
            nombre_dueno: perro.user.nombre
          }
        end
  
        render 'verificar_disponibilidad'
      else
        flash[:error] = 'Perro no encontrado'
        redirect_to cruza_path
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
  
      def mis_perros_cruza
        @mis_perros_cruza = Perro.where(user_id: current_user.id, cruza: true)
      end
  end
  