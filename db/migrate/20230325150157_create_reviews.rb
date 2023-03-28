class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.integer :writer_id
      t.integer :rating

      t.timestamps
    end
  end
end
