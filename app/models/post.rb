class Post < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  enum sex: { man: 0,women: 1,unisex: 2 }
  
end
