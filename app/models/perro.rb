class Perro < ApplicationRecord
  belongs_to :user
  belongs_to :raza
  has_many :historial_vacunas
  has_many :historial_turnos

  

  attr_accessor :dueño_dni
  validates :nombre, presence: { message: "No puede estar en blanco" }

  before_validation :nombre_unico_por_usuario

  def nombre_unico_por_usuario
    # Verifica si hay algún otro perro del mismo usuario con el mismo nombre
    if Perro.exists?(nombre: nombre, user_id: user_id)
      errors.add(:nombre, 'ya está en uso para este usuario')
    end
  end
end