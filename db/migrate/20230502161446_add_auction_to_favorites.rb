class AddAuctionToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_reference :favorites, :auction, null: true, foreign_key: true, default: nil
  end
end
