class HistorialTurnosController < ApplicationController

    def new
        @turno = HistorialTurno.new
        @vacunas = Vacuna.all
        @tipo = TipoTurno.all
        @perros = current_user.perros
        render 'solicitar_turno'
    end

    def create

        @turno = HistorialTurno.new(turno_parametros)
        @turno.condition = Condition.find_by(id: 2) 
        
        if @turno.save
            redirect_to root_path, notice: 'Turno solicitado con éxito.'
        else
            puts @turno.errors.full_messages           
            render 'solicitar_turno'
        end
    end      
    
    private

    def turno_parametros
        params.require(:historial_turno).permit(:fecha_y_hora, :franja, :tipo_turno_id, :perro_id)
    end


end
