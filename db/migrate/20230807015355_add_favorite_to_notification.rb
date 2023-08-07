class AddFavoriteToNotification < ActiveRecord::Migration[7.0]
  def change
    add_reference :notifications, :favorite, null: true, foreign_key: true, default: nil
  end
end
