class AddResueltoToHelp < ActiveRecord::Migration[7.0]
  def change
    add_column :helps, :resolved, :boolean, default: false
  end
end
