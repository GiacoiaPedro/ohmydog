class MisTurnosController < ApplicationController
  def index
    # Obtén los perros asociados al usuario actual
    perros = current_user.perros

    # Obtén los historiales de turno asociados a esos perros
    @mis_turnos = HistorialTurno.where(perro_id: perros)
  end
end
