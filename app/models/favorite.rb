class Favorite < ApplicationRecord
  belongs_to :horse, optional: true
  belongs_to :user
  belongs_to :auction, optional: true
  has_many :notifications, dependent: :destroy
end
