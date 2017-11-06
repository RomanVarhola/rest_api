class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]

  scope :only_users, -> { where(role: 'user') }
  scope :search, -> (search) { where('lower(email) LIKE ? OR lower(first_name) LIKE ? OR lower(last_name) LIKE ?',"%#{search.to_s.downcase}%", "%#{search.to_s.downcase}%", "%#{search.to_s.downcase}%") }

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
