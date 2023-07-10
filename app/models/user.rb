class User < ApplicationRecord
  has_many :horses, dependent: :destroy
  has_many :auctions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :photo, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  # validates :nombre, presence: true
  # validates :apellido, presence: true
  # validates :direccion, presence: true
  # validates :ciudad, presence: true
  # validates :provincia, presence: true
  # validates :pais, presence: true
  # validates :phone, presence: true
  # validates :email, presence: true
  # validates :password, presence: true

  def update_rating
    reviews = Review.where(user_id: self.id)
    sum = 0
    reviews.each do |review|
      sum += review.rating
    end
    self.rating = sum.to_f / reviews.count
    self.save
  end
end
