class Campaign < ApplicationRecord

    mount_uploader :imagen, ImagenUploader
end

#La función mount_uploader es un método proporcionado por algunas gemas de manejo de imágenes en Rails, como CarrierWave o Shrine. Este método se utiliza para configurar el manejo 
#de archivos adjuntos, como imágenes, en tus modelos.

#En el contexto de tu pregunta anterior,
#relacionada con la adición de una columna para imágenes en un modelo User, mount_uploader se utilizaría para indicar a Rails cómo manejar la carga y el almacenamiento 
#de imágenes en esa columna específica.
