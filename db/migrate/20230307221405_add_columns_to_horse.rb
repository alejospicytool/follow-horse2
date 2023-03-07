class AddColumnsToHorse < ActiveRecord::Migration[7.0]
  def change
    add_column :horses, :rider, :string
    add_column :horses, :alzada, :string
    add_column :horses, :height, :string
    add_column :horses, :gender, :string
    add_column :horses, :video, :string
    rename_column :horses, :age, :birthday
    change_column :horses, :birthday, :string
  end
end
