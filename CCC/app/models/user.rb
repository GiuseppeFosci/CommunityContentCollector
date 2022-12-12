class User < ApplicationRecord
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  validates :surname, presence: true, length: {maximum:50}
  
  VALID_EMAIL_REGEX = /\A([a-z]+(.)\d{6,7}(@studenti.uniroma1.it))|([a-z]+(.)[a-z]+(@uniroma1.it))\z/i

  validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  
  #bcrypt password sicura
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
    BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
