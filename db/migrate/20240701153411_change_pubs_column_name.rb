class ChangePubsColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :pubs, :type, :asset_type
  end
end
