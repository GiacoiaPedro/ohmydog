class HistorialTurno < ApplicationRecord
  belongs_to :tipo_turno
  belongs_to :perro
  belongs_to :condition



  validates :perro_id, presence: { message: "Debe seleccionar un perro" }
  validates :tipo_turno_id, presence: { message: "Debe seleccionar un tipo de turno" }

  after_create :send_mail
  validate :rango_fecha_valida
  validate :fecha_y_hora_unicas

  private

  def send_mail
    HistorialTurnoMailer.new_historial_turno(self).deliver_later
  end


  def fecha_y_hora_unicas
    if HistorialTurno.exists?(fecha_y_hora: fecha_y_hora)  
      errors.add(:fecha_y_hora, "reservada para la fecha pedida")
    end
  end

  def rango_fecha_valida
    unless fecha_y_hora.present? && (fecha_y_hora >= DateTime.tomorrow && fecha_y_hora <= 1.year.from_now)
      errors.add(:fecha_y_hora, " debe estar entre mañana y un año")
    end
  end

end
