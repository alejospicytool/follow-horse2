class RemoveDateFromAuction < ActiveRecord::Migration[7.0]
  def change
    remove_column :auctions, :date
  end
end
