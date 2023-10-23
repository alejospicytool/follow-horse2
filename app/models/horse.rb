class Horse < ApplicationRecord
  ALLOWED_VIDEO_FORMATS = %w(
    video/quicktime video/mpeg video/avi video/x-flv video/x-f4v
    video/mp4 video/x-m4v video/x-ms-asf video/x-ms-wmv video/x-ms-wmx
    video/x-ms-wvx video/vob video/mod video/3gpp video/3gpp2
    video/x-matroska video/divx video/xvid video/webm
  )
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :food_photo, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  before_validation :set_age_and_birthday, :ensure_full_url
  
  with_options presence: true do
    validates :name, :age, :birthday, :gender
    validates :photos
  end

  validate :colt_fields

  private

  def colt_fields
    # Los potros no necesitan estos campos.
    if age && age > 4
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

  def ensure_full_url
    self.pedigree = if pedigree =~ /\Ahttps?:\/\//
      pedigree
    else
    "http://#{pedigree}"
    end
  end
end
