class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :tipo
      t.string :description
      t.references :conversation, foreign_key: true
      t.references :horse, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
