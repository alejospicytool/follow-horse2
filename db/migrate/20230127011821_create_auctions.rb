class CreateAuctions < ActiveRecord::Migration[7.0]
  def change
    create_table :auctions do |t|
      t.string :name
      t.string :location
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
