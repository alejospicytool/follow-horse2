class Horse < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many_attached :photos
end
