class Horse < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :food_photo, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  before_validation :set_age_and_birthday
  
  with_options presence: true do
    validates :name, :age, :birthday, :gender
    validates :photos
  end

  validate :colt_fields

  private

  def colt_fields
    # Los potros no necesitan estos campos.
    if age > 4
      errors.add(:rider, "No puede estar vacio") if rider.blank?
      errors.add(:height, "No puede estar vacio") if height.blank?
    end
  end

  def set_age_and_birthday
    if self.birthday
      self.age = ((Date.today - self.birthday) / 365).to_i
      self.birthday = self.birthday.strftime("%d/%m/%Y")
    end
  end
end
