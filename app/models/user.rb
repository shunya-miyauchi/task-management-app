class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :admin_destroy
  before_update :admin_update

  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, uniqueness: true, length: {maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: {minimum: 6}, on: :create
  
  has_secure_password
  has_many :tasks, dependent: :destroy

  private

  def admin_destroy
    user = User.where(admin: "true").count
    throw(:abort) if self.admin && user <= 1
  end

  def admin_update
    user_count = User.where(admin: "true").count
    user = User.find_by(id: self.id)
    throw(:abort) if  self.admin == false && user_count == 1 && self.name == user.name && self.email == user.email
  end
end