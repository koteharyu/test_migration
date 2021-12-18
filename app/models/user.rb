class User < ApplicationRecord
  validates :name, presence: true

  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users
end
