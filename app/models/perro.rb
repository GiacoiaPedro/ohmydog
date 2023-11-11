class Perro < ApplicationRecord
  has_many :historial_vacunas
  has_many :historial_turnos
  belongs_to :raza
  belongs_to :user
end
