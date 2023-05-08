class AddHorseIdToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_reference :favorites, :horse, null: true, foreign_key: true, default: nil
  end
end
