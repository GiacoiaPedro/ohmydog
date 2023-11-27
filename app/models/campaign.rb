class Campaign < ApplicationRecord

    mount_uploader :imagen, ImagenUploader
    validate :nombre_unico_si_activa
    validates :monto, presence: true, numericality: { greater_than_or_equal_to: 1, message: ': no puede ser menor a 1' }
    validates :imagen, presence: true, unless: :imagen_existente?

    def imagen_existente?
        imagen.present? && imagen.file.exists?
      end
        def nombre_unico_si_activa
          if activa? && Campaign.where('LOWER(nombre) = LOWER(?) AND activa = ?', nombre, true).where.not(id: id).exists?
            errors.add(:nombre, 'ya existe una campaña activa con ese nombre')
          end
        end 
end

