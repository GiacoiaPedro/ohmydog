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
end
