class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: 'user_id'
  has_many :commit, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'

  def self.recent_posts(user_id)
    Post.where(user_id: user_id).limit(3).order(created_at: :asc)
  end
end
