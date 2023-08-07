class AddMessageToNotification < ActiveRecord::Migration[7.0]
  def change
    add_reference :notifications, :message, null: true, foreign_key: true, default: nil
  end
end
