class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follower, class_name: "Relationship"
  has_many :followed, class_name: "Relationship"

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

end
