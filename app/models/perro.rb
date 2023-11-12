class Perro < ApplicationRecord
  belongs_to :user
  has_many :historial_vacunas
  has_many :historial_turnos
end
