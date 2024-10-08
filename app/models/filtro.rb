class Filtro
  include ActiveModel::Model

  attr_accessor :jinete, :edad, :altura, :pais
  def initialize(attributes = {})
    @jinete = attributes["jinete"]
    @edad = attributes["edad"]
    @altura = attributes["altura"]
    @pais = attributes["pais"]
  end
end
