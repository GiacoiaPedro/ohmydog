class RenameMontoToSaldoInTarjeta < ActiveRecord::Migration[7.1]
  def change
    rename_column :tarjeta, :monto, :saldo
  end
end
