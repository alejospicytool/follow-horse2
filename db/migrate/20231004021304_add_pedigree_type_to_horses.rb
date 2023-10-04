class AddPedigreeTypeToHorses < ActiveRecord::Migration[7.0]
  def change
    add_column :horses, :pedigree_type, :string
  end
end
