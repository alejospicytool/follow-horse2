class Horse < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  validates :name, presence: true
  validates :age, presence: true
  validates :height, presence: true
  validates :rider, presence: true
  validates :birthday, presence: true
  validates :photos, presence: true
  validates :alzada, presence: true
  validates :gender, presence: true
  validates :video, presence: true
end
