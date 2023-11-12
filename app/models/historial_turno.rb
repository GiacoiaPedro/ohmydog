class HistorialTurno < ApplicationRecord
  belongs_to :tipo_turno
  belongs_to :perro
end
