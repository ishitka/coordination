class Post < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :sex, presence: true
  
  def favorited_by?(user)
    user.present? && favorites.exists?(user_id: user.id)
  end
  
  enum sex: { man: 0,woman: 1,unisex: 2 }
  
  def self.looks(search, word, sex)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{ward}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?", "#{ward}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?", "%#{ward}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?", "%#{ward}%")
    else
      @post = Post.all
    end
  end

  def self.liked_posts(user, page, per_page)
    includes(:post_favorites)
    .where(post_favorites: { user_id: user.id})
    .order(created_at: :desc)
    .page(page)
    .per(per_page)
  end
  
end
