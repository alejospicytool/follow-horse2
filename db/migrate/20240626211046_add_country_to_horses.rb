class AddCountryToHorses < ActiveRecord::Migration[7.0]
  def change
    add_column :horses, :country, :string
  end
end
