class HistorialTurno < ApplicationRecord
  belongs_to :tipo_turno
  belongs_to :perro
  belongs_to :condition

  
  validates :perro_id, presence: { message: "Debe seleccionar un perro" }
  validates :tipo_turno_id, presence: { message: "Debe seleccionar un tipo de turno" }

  validate :rango_fecha_valida
  validate :uniqueness_of_turnos, on: :create
  private

  def send_mail
    HistorialTurnoMailer.new_historial_turno(self).deliver_later
  end

  validate :rango_fecha_valida

  private

  def uniqueness_of_turnos
    existing_turnos = HistorialTurno.where(perro_id: perro_id, condition_id: [1, 2]).where.not(id: id)

    if existing_turnos.exists?
      errors.add(:perro_id, "El perro ya tiene un turno en pendiente o confirmado.")
    end
  end

  def rango_fecha_valida
    unless fecha? && (fecha >= Date.tomorrow && fecha <= 1.year.from_now)  
          errors.add(:fecha, " debe estar entre mañana y un año")
    end
  end

end
