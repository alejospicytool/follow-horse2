class CreateHorses < ActiveRecord::Migration[7.0]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :description
      t.string :pedigree
      t.integer :age
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
