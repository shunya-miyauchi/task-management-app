class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :admin_exist

  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, uniqueness: true, length: {maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: {minimum: 6}, on: :create
  
  has_secure_password
  has_many :tasks, dependent: :destroy

  private

  def admin_exist
    user = User.where(admin: "true").count
    throw(:abort) if user < 2
  end

end
