class User < ApplicationRecord
  has_secure_password

  extend FriendlyId
    friendly_id :name, use: :slugged

  has_many :post_users, dependent: :destroy
  has_many :posts, through: :post_users
  has_many :comments

  validates :email, uniqueness: true
  validates :name, :email, :current_city, :password, presence: true

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user ? @user.authenticate(params[:password]) : false
  end

end
