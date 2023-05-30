class Filtro
  include ActiveModel::Model

  attr_accessor :jinete, :edad, :altura, :ubicacion
  def initialize(attributes = {})
    @jinete = attributes["jinete"]
    @edad = attributes["edad"]
    @altura = attributes["altura"]
    @ubicacion = attributes["ubicacion"]
  end
end
