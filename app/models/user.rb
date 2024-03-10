class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, presence: { message: 'は必須事項です' }, allow_blank: false
  validates :account, presence: { message: 'は必須事項です' }, allow_blank: false
  validates :account, format: { with: /\A.*@.*\z/, message: "には@を含める必要があります" }, allow_blank: false
  validates :telephone_number, presence: { message: 'は必須事項です' }, allow_blank: false
  validates :email, uniqueness: { message: "すでに登録されています" }, allow_blank: true # 入力がない場合にも一意性チェックを行いたい場合、allow_blank: true
  validates :telephone_number, uniqueness: { message: "すでに登録されています" }, allow_blank: true # 入力がない場合にも一意性チェックを行いたい場合、allow_blank: true
  validates :account, uniqueness: { message: "すでに登録されています" }, allow_blank: true 
  

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("account LIKE?", "#{word}")
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
  
  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width,height]).processed
  end

end
