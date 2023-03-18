class AddCondicionesToRemate < ActiveRecord::Migration[7.0]
  def change
    add_column :auctions, :condiciones, :string
  end
end
