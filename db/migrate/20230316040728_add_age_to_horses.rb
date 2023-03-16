class AddAgeToHorses < ActiveRecord::Migration[7.0]
  def change
    add_column :horses, :age, :integer
  end
end
