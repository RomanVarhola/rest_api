class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]

  scope :only_users, -> { where(role: 0) }

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
