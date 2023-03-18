class CreateLoteModel < ActiveRecord::Migration[7.0]
  def change
    create_table :lotes do |t|
      t.string :numero_lote
      t.string :nombre_caballo
      t.string :descripcion
      t.date :fecha_nacimiento
      t.string :sexo
      t.string :alzada
      t.string :pedigree
      t.string :video
      t.references :auction, null: false, foreign_key: true
      t.timestamps
    end
  end
end
