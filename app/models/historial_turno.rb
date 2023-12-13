class HistorialTurno < ApplicationRecord
  belongs_to :tipo_turno
  belongs_to :perro
  belongs_to :condition

  validates :perro_id, presence: { message: "Debe seleccionar un perro" }
  validates :tipo_turno_id, presence: { message: "Debe seleccionar un tipo de turno" }

  validate :rango_fecha_valida
  validate :uniqueness_of_turnos, on: :create

  validate :validar_turno_existente_castracion, if: -> { tipo_turno_id == 6 }
  validate :validar_turno_existente_vacunaA, if: -> { tipo_turno_id == 1 }
  validate :validar_turno_existente_vacunaB, if: -> { tipo_turno_id == 7 }

  validate :validar_edad_perro_castracion, if: -> { tipo_turno_id == 6 }
  validate :validar_edad_perro_vacuna_a, if: -> { tipo_turno_id == 1 || tipo_turno_id == 8 }

  validate :validar_edad_perro_vacuna_b, if: -> { tipo_turno_id == 7 || tipo_turno_id == 9}

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

  validate :validar_refuerzo_vacuna_a, if: -> { tipo_turno_id == 8 }
  validate :validar_refuerzo_vacuna_b, if: -> { tipo_turno_id == 9 }

  private

  def validar_refuerzo_vacuna_a
    
    # Verifica si hay un turno con vacuna A (tipo_turno_id: 1) y condition_id: [1, 2]
    turno_vacuna_a = HistorialTurno.where(perro_id: perro_id, tipo_turno_id: 1, condition_id: 4).first

    # Agrega errores si no se cumple la condición
    unless turno_vacuna_a
      errors.add(:tipo_turno_id, "Debe tener un turno con vacuna A en estado finalizado.")
    end
  end

  def validar_refuerzo_vacuna_b
    
    # Verifica si hay un turno con vacuna A (tipo_turno_id: 1) y condition_id: [1, 2]
    turno_vacuna_a = HistorialTurno.where(perro_id: perro_id, tipo_turno_id: 7, condition_id: 4).first

    # Agrega errores si no se cumple la condición
    unless turno_vacuna_a
      errors.add(:tipo_turno_id, "Debe tener un turno con vacuna A en estado finalizado.")
    end
  end

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

  def validar_turno_existente_castracion
    existing_turnos = HistorialTurno.where(perro_id: perro_id, tipo_turno_id: 6).where.not(id: id)

    if existing_turnos.exists?
      errors.add(:tipo_turno_id, "El perro ya esta castrado.")
    end
  end

  def validar_turno_existente_vacunaA
    existing_turnos = HistorialTurno.where(perro_id: perro_id, tipo_turno_id: 1, condition_id: 4).where.not(id: id)

    if existing_turnos.exists?
      errors.add(:tipo_turno_id, "El perro ya tiene la vacuna A.")
    end
  end

  def validar_turno_existente_vacunaB
    existing_turnos = HistorialTurno.where(perro_id: perro_id, tipo_turno_id: 7, condition_id: 4).where.not(id: id)

    if existing_turnos.exists?
      errors.add(:tipo_turno_id, "El perro ya tiene la vacuna B.")
    end
  end

  def validar_edad_perro_vacuna_a
    puts "Validando edad para vacuna A"
    # Verifica que el perro no sea nulo y tenga fecha de nacimiento
    if perro && perro.fecha_nacimiento
      # Calcula la edad en meses del perro
      edad_en_meses = ((Date.current - perro.fecha_nacimiento) / 30).to_i
      # Revisa si tiene un mes o menos
      if edad_en_meses < 2
        errors.add(:tipo_turno_id, "El perro debe tener más de 2 meses para solicitar una vacuna de tipo A")
      end
    else
      errors.add(:perro, "El perro es nulo o no tiene fecha de nacimiento")
    end
  end

  def validar_edad_perro_vacuna_b
    puts "Validando edad para vacuna B"
    # Verifica que el perro no sea nulo y tenga fecha de nacimiento
    if perro && perro.fecha_nacimiento
      # Calcula la edad en meses del perro
      edad_en_meses = ((Date.current - perro.fecha_nacimiento) / 30).to_i
      # Revisa si tiene un mes o menos
      if edad_en_meses < 4
        errors.add(:tipo_turno_id, "El perro debe tener más de 4 meses para solicitar una vacuna de tipo B")
      end
    else
      errors.add(:perro, "El perro es nulo o no tiene fecha de nacimiento")
    end
  end

  def validar_edad_perro_castracion
    # Calcula la edad en meses del perro
    edad_en_meses = ((Date.current - perro.fecha_nacimiento) / 30).to_i

    if edad_en_meses < 6
      errors.add(:tipo_turno_id, "El perro debe tener más de 6 meses para solicitar una castración.")
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
