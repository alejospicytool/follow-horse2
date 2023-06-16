class Lote < ApplicationRecord
  belongs_to :auction
  has_one_attached :photo, dependent: :destroy
end
