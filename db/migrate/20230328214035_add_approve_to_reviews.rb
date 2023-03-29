class AddApproveToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :approve, :boolean, default: false
  end
end
