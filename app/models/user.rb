class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable ,
        :trackable, authentication_keys: [:dni]
  
  belongs_to :rol
  has_many :perros
end

#Linea   :trackable, authentication_keys: [:dni] agregada
