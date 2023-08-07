class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :message, optional: true
  belongs_to :conversation, optional: true
  belongs_to :horse, optional: true
  belongs_to :favorite, optional: true
  belongs_to :auction, optional: true
end
