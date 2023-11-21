class Campaign < ApplicationRecord

    mount_uploader :imagen, ImagenUploader
    validates :nombre, presence: true, uniqueness: { case_sensitive: false, message:': ya existe una campaña con ese nombre' }
    validates :monto, presence: true, numericality: { greater_than_or_equal_to: 0, message: ': no puede ser menor a 0' }
    validates :imagen, presence: true, unless: :imagen_existente?

    def imagen_existente?
        imagen.present? && imagen.file.exists?
      end
    
end

