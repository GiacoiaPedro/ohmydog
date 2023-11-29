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
        @turno.update(condition_id: 3) # Actualiza el condition_id a 3 para "cancelado"
        redirect_to turnos_confirmados_historial_turnos_path, notice: 'Turno cancelado con éxito.'
    end
    

    def hoy
        @turnos_confirmados = HistorialTurno.where(fecha: Date.tomorrow, condition_id: 2)
    end

    def agregar_consulta
        @turno = HistorialTurno.find(params[:id])
        new_texto = params[:historial_turno][:consulta]
        
        if new_texto.present?
            @turno.update(consulta: new_texto, condition_id: 4)

            # Si el tipo de turno es 1, también maneja la creación de Vaccine
            if @turno.tipo_turno_id == 1
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
        params.require(:vaccine).permit(:vacuna_id, :peso, :texto)
      end

      def deworm_params
        params.require(:deworm).permit(:cantidad, :texto)
      end

    def turno_hora_parametros
        params.require(:historial_turno).permit(:hora)
    end


    def turno_parametros
        params.require(:historial_turno).permit(:fecha, :franja, :tipo_turno_id, :perro_id)
    end



end
