class AddsStartAndFinishToAuctions < ActiveRecord::Migration[7.0]
  def change
    add_column :auctions, :start, :datetime
    add_column :auctions, :finish, :datetime
  end
end
