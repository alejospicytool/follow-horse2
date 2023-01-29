class Horse < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
end
