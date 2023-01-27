class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :age, :integer
    add_column :users, :descrption, :string
    add_column :users, :establishment, :string
  end
end
