class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy #1つのルームにいるユーザーの数は2人のためhas_manyになる
  has_many :chats, dependent: :destroy
end
