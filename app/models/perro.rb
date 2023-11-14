class Perro < ApplicationRecord
  belongs_to :user
  has_many :historial_vacunas
  has_many :historial_turnos

  attr_accessor :dueño_dni
  validates :nombre, presence: { message: "No puede estar en blanco" }
  


end
