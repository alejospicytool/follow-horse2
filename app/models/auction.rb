class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_one_attached :photo, dependent: :destroy
  has_many :lotes, dependent: :destroy

  validates :name, presence: true
  validates :link_auction, presence: true
  validates :location, presence: true
  validates :start, presence: true
  validates :finish, presence: true

  validate :start_and_finish_dates_cannot_be_in_the_past
  validate :start_and_finish_dates

  def start_and_finish_dates_cannot_be_in_the_past
    if start.present? && start < Time.now
      errors.add(:start, "no puede ser en el pasado")
    end
  end

  def start_and_finish_dates
    if start.present? && finish.present? && finish < start
      errors.add(:finish, "no puede ser anterior a la fecha de inicio")
    end
  end

end
