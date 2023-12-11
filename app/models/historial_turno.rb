class HistorialTurno < ApplicationRecord
  belongs_to :tipo_turno
  belongs_to :perro
  belongs_to :condition

  
  validates :perro_id, presence:{ message: "Debe seleccionar un perro"  }
  validates :tipo_turno_id, presence: { message: "Debe seleccionar un tipo de turno" }
  
  validate :rango_fecha_valida
  validate :uniqueness_of_turnos, on: :create
  
  validate :validar_turno_existente, if: -> { tipo_turno_id == 6 }
  validate :validar_edad_perro_castracion, if: -> { tipo_turno_id == 6 }
  validate :validar_edad_perro_vacuna_a, if: -> { tipo_turno_id == 1 }
  validate :validar_edad_perro_vacuna_b, if: -> { tipo_turno_id == 7 }


  def tiempo_restante_para_cancelar_en_horas
    if fecha.present? && hora.present?
    tiempo_restante = tiempo_restante_para_cancelar
    horas_restantes = tiempo_restante / 1.hour.to_f
    horas_restantes.round(2) # Redondea a dos decimales para mayor claridad
  end
end


  def mostrar_boton_cancelar?
    if fecha.present? && hora.present?
    tiempo_restante_para_cancelar_en_horas > 24
    end
  end


  private


  def tiempo_restante_para_cancelar
    # Calcula la diferencia en tiempo entre la fecha y hora del turno y la fecha y hora actuales
    if fecha.present? && hora.present?
    fecha_y_hora_del_turno - Time.now
    end
  end

  def fecha_y_hora_del_turno
    # Combina la fecha y hora del turno para obtener un objeto Time
    if fecha.present? && hora.present?
    Time.new(fecha.year, fecha.month, fecha.day, hora.hour, hora.min, hora.sec)
    end

  end

  def validar_turno_existente
    existing_turnos = HistorialTurno.where(perro_id: perro_id, tipo_turno_id: 6).where.not(id: id)

    if existing_turnos.exists?
      errors.add(:tipo_turno_id, "El perro ya esta castrado.")
    end
  end

  def validar_edad_perro_vacuna_a
    # Calcula la edad en meses del perro
    edad_en_meses = ((Date.current - perro.fecha_nacimiento) / 30).to_i
    #Revisa si tiene un mes o menos
    if edad_en_meses <= 1
      errors.add(:tipo_turno_id, "El perro debe tener más de 2 meses para solicitar una vacuna de tipo A")
    end
  end

  def validar_edad_perro_vacuna_b
    # Calcula la edad en meses del perro
    edad_en_meses = ((Date.current - perro.fecha_nacimiento) / 30).to_i

    if edad_en_meses <= 3
      errors.add(:tipo_turno_id, "El perro debe tener más de 4 meses para solicitar una vacuna de tipo B")
    end
  end

  def validar_edad_perro_castracion
    # Calcula la edad en meses del perro
    edad_en_meses = ((Date.current - perro.fecha_nacimiento) / 30).to_i

    if edad_en_meses <= 5
      errors.add(:tipo_turno_id, "El perro debe tener más de 6 meses para solicitar una castracion.")
    end
  end

  def send_mail
    HistorialTurnoMailer.new_historial_turno(self).deliver_later
  end

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
