class HistorialTurnosController < ApplicationController
    respond_to :html, :json

    def new
        @turno = HistorialTurno.new
        @vacunas = Vacuna.all
        @tipo = TipoTurno.all
        @perros = current_user.perros
        render 'solicitar_turno'
    end



    def create
        @turno = HistorialTurno.new(turno_parametros)
        @turno.condition = Condition.find_by(id: 1) 
        
        if @turno.save            
            SolicitarTurnoMailer.with(turno: @turno).confirm.deliver_later #Lo envia de manera asincrona
            redirect_to root_path, notice: 'Turno solicitado con éxito.'
        else
            puts @turno.errors.full_messages           
            render 'solicitar_turno'
        end
    end  
    

    def pendientes
        @turnos_pendientes = HistorialTurno.where(condition_id: 1, hora: nil)
        @nuevo_turno_con_hora = HistorialTurno.new
    end

    def agregar_horario
        @turno = HistorialTurno.find(params[:id])
        new_hora = params[:historial_turno][:hora]
        
        if new_hora.present?
            # Parsea la hora en un objeto Time (por ejemplo, 09:09 AM)
            @turno.update(hora: new_hora, condition_id: 2) 
            AgregarHorarioMailer.with(turno: @turno).agregar.deliver_later
            redirect_to turnos_pendientes_historial_turnos_path, notice: 'Hora agregada con éxito.'
        else
            # Manejar el caso en que new_hora no está presente
            render 'pendientes', notice: "No se pudo agregar el horario ni cambiar a confirmado"
        end
    end

    def agregar_texto
        @turno = HistorialTurno.find(params[:id])
        new_texto = params[:historial_turno][:texto]
        
        if new_texto.present?
            @turno.update(texto: new_texto, condition_id: 3)
            CambiarFechaMailer.with(turno: @turno).cambiar.deliver_later
            redirect_to turnos_pendientes_historial_turnos_path, notice: 'Mail enviado con éxito.'
        else
            render 'pendientes', notice: 'No se pudo enviar el mail'
        end
    end

    def confirmados
        @turnos_confirmados = HistorialTurno.where(condition_id: 2)
    end

      def cancelar_turno
        @turno = HistorialTurno.find(params[:id])
        
        # Actualiza el condition_id a 3 para "cancelado"
        if @turno.update(condition_id: 3)
          # Envía el correo u otras acciones si es necesario
          if current_user.rol_id == 1
          CancelarTurnoMailer.with(turno: @turno).cancelar.deliver_later
          end 

          flash[:notice] = 'Turno cancelado con éxito.'
        else
          # Maneja el caso en que la actualización falla
          flash[:notice] = 'No se pudo cancelar el turno'
        end

        redirect_back(fallback_location: root_path)
      end
    

    def hoy
        @turnos_confirmados = HistorialTurno.where(fecha: Date.today , condition_id: 2)
    end

    def agregar_consulta
        @turno = HistorialTurno.find(params[:id])
        new_texto = params[:historial_turno][:consulta]
        edad_en_meses = ((Date.current - @turno.perro.fecha_nacimiento) / 30).to_i

      
        if new_texto.present?
          # Actualizar los atributos del turno
          @turno.update(consulta: new_texto, condition_id: 4, monto: params[:historial_turno][:monto])


          if @turno.tipo_turno_id == 1  && edad_en_meses < 4
          # Lógica para crear el próximo turno 21 días después
          proxima_fecha = fecha_proximo_turno_2_meses(@turno.fecha)
          nuevo_turno = HistorialTurno.create(
          perro_id: @turno.perro_id,
          tipo_turno_id: 8,
          fecha: proxima_fecha,
          condition_id: 1  # O el condition_id adecuado para un nuevo turno pendiente
          )
          end

          if @turno.tipo_turno_id == 1  && edad_en_meses > 3 
            # Lógica para crear el próximo turno 21 días después
            proxima_fecha = fecha_proximo_turno_4_meses(@turno.fecha)
            nuevo_turno = HistorialTurno.create(
            perro_id: @turno.perro_id,
            tipo_turno_id: 8,
            fecha: proxima_fecha,
            condition_id: 1  # O el condition_id adecuado para un nuevo turno pendiente
            )
            end

            if @turno.tipo_turno_id == 7
              # Lógica para crear el próximo turno 21 días después
              proxima_fecha = fecha_proximo_turno_4_meses(@turno.fecha)
              nuevo_turno = HistorialTurno.create(
              perro_id: @turno.perro_id,
              tipo_turno_id: 9,
              fecha: proxima_fecha,
              condition_id: 1  # O el condition_id adecuado para un nuevo turno pendiente
              )
              end

          if @turno.tipo_turno_id == 1 || @turno.tipo_turno_id == 7
            vaccine_params = params.require(:historial_turno).require(:vaccine).permit(:peso, :vacuna_id)
            @vaccine = Vaccine.new(vaccine_params)
            @vaccine.historial_turno = @turno
            @vaccine.save
          end
      
          if @turno.tipo_turno_id == 4
            deworm_params = params.require(:historial_turno).require(:deworm).permit(:cantidad)
            @deworm = Deworm.new(deworm_params)
            @deworm.historial_turno = @turno
            @deworm.save
          end
      
          redirect_to turnos_hoy_historial_turnos_path, notice: 'Turno finalizado con éxito'
        else
          render 'hoy', notice: 'No se pudo finalizar el turno'
        end
      end

      def create_vaccine
        @turno = HistorialTurno.find(params[:id])
        @vaccine = Vaccine.new(vaccine_params)
        @vaccine.historial_turno = @turno
    
        if @vaccine.save
          redirect_to turnos_confirmados_path, notice: 'Vacuna registrada exitosamente.'
        else
          render 'turnos_confirmados' # Puedes cambiar esto según cómo manejes la redirección en tu aplicación
        end
      end
    
    private

    def vaccine_params
        params.require(:vaccine).permit(:vacuna_id, :peso, :texto, :monto)
      end

      def deworm_params
        params.require(:deworm).permit(:cantidad, :texto, :monto)
      end

    def turno_hora_parametros
        params.require(:historial_turno).permit(:hora)
    end


    def turno_parametros
        params.require(:historial_turno).permit(:fecha, :franja, :tipo_turno_id, :perro_id)
    end

    def fecha_proximo_turno_2_meses(fecha_actual)
      fecha_actual + 21.days
    end

    def fecha_proximo_turno_4_meses(fecha_actual)
      fecha_actual + 365.days
    end







end
