class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_one_attached :photo
end
