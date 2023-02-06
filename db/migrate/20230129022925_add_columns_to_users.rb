class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nombre, :string
    add_column :users, :apellido, :string
    add_column :users, :direccion, :string
    add_column :users, :provincia, :string
    add_column :users, :ciudad, :string
    add_column :users, :pais, :string
  end
end
