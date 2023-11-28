class Servicio < ApplicationRecord
    validates :dni, uniqueness: { scope: [:tipo, :habilitado], message: "ya está registrado como paseador" }, if: -> { tipo == "2" && habilitado == 0 }
    validates :mail, uniqueness: { scope: [:tipo, :habilitado], message: "ya está registrado como paseador" }, if: -> { tipo == "2" && habilitado == 0 }
    validates :dni, uniqueness: { scope: [:tipo, :habilitado], message: "ya está registrado como cuidador" }, if: -> { tipo == "1" && habilitado == 0 }
    validates :mail, uniqueness: { scope: [:tipo, :habilitado], message: "ya está registrado como cuidador" }, if: -> { tipo == "1" && habilitado == 0 }
  end