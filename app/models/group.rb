class Group < ApplicationRecord
  has_many :groups
  has_many :users, through: :group_users
  
  validates :name, presence: true
  validates :introduction, presence: true
  
  def get_image
    (image_id.attached?) ? image : 'no_image.jpg'
  end
end
