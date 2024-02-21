class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, presence: { message: 'は必須事項です' }
  validates :account, presence: { message: 'は必須事項です' }
  validates :account, format: { with: /\A.*@.*\z/, message: "アカウントIDには@を含める必要があります" }
  validates :telephone_number, presence: { message: 'は必須事項です' }
  validates :email, uniqueness: true
  validates :telephone_number, uniqueness: true
  validates :account, uniqueness: true
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("account LIKE?", "#{ward}")
    elsif search == "forward_match"
      @user = User.where("account LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("account LIKE?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("account LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

end
