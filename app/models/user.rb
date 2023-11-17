class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable ,
        :trackable, authentication_keys: [:dni]

        validates :password, password_strength: false

  # Sobrescribe el método password_required?
  def password_required?
    # Solo se requiere contraseña si no se está creando un nuevo usuario
    new_record? ? false : super
  end

  belongs_to :rol


  validate :validate_fecha_nacimiento

  def validate_fecha_nacimiento
    if fecha_nacimiento.present? && fecha_nacimiento > 18.years.ago.to_date
      errors.add(:fecha_nacimiento, ": El usuario debe ser mayor a 18 años ")
    end
  end


end