class Pubs < ActiveRecord::Migration[7.0]
  def change
    create_table :pubs do |t|
      t.string :url
      t.string :type

      t.timestamps
    end
  end
end
