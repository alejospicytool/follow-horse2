class AddLinkColumnToRemate < ActiveRecord::Migration[7.0]
  def change
    add_column :auctions, :link_auction, :string
  end
end
