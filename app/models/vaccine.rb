class Vaccine < ApplicationRecord
  belongs_to :vacuna
  belongs_to :historial_turno
end
