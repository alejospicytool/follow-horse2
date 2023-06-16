class ChangeBirthdayDataTypeInHorses < ActiveRecord::Migration[7.0]
  def up
    change_column :horses, :birthday, 'date USING TO_DATE(birthday, \'DD/MM/YYYY\')'
  end

  def down
    change_column :horses, :birthday, :string
  end
end
