class PerroPerdido < ApplicationRecord
    belongs_to :raza
    mount_uploader :foto, ImagenUploader
    belongs_to :user

  
    # Validaciones
    validates :sexo, :raza_id, :comportamiento, :lugar, :fecha, :foto, :edad, presence: true
    validates :edad, numericality: { greater_than: 0, message: ": no puede ser menor a 0 meses" }
    validate :fecha_menor_a_fecha_actual
    validates :mail, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "debe tener un formato de correo electrónico válido" }

  
    private
  
    def fecha_menor_a_fecha_actual
      if fecha.present? && fecha > Date.current
        errors.add(:fecha, ": debe ser menor o igual a la fecha actual")
      end
    end
  end
  