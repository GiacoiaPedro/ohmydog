require 'securerandom'

def generate_random_password(length = 12)
  SecureRandom.urlsafe_base64(length).tr('lIO0', 'sxyz')
end

# Genera una contraseña aleatoria
random_password = generate_random_password

# Imprime un mensaje sin mostrar la contraseña
puts "Se ha generado una contraseña aleatoria."

# Puedes utilizar la variable `random_password` en tu aplicación según sea necesario