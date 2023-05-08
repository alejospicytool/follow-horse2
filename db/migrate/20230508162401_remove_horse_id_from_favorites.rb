class RemoveHorseIdFromFavorites < ActiveRecord::Migration[7.0]
  def change
    remove_column :favorites, :horse_id, :bigint
  end
end
