class Tarjeta < ApplicationRecord
    attr_accessor :monto_temporal

    def suficiente_saldo?
      monto_temporal.to_i <= saldo
    end
end
