class Perro < ApplicationRecord
  belongs_to :user
  belongs_to :raza
  has_many :historial_vacunas
  has_many :historial_turnos

  

  attr_accessor :dueño_dni
  validates :nombre, presence: { message: "No puede estar en blanco" }
  validates_uniqueness_of :nombre, scope: :user_id, message: 'ya está en uso para este usuario'

end