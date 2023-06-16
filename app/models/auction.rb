class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_one_attached :photo, dependent: :destroy
  has_many :lotes, dependent: :destroy
end
