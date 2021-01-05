require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_REGEXP = /\A\w+\z/
  VALID_COLOR_REGEX = /\A#(?:[0-9a-fA-F]{3}){1,2}\z/

  attr_accessor :password

  has_many :questions

  before_save :encrypt_password
  before_save :downcase_params

  validates :username, :email, presence: true, uniqueness: true
  validates :username, length: { maximum: 40 }, format: { with: USERNAME_REGEXP }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates_confirmation_of :password
  validates :color, format: {with: VALID_COLOR_REGEX}

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    return nil unless user.present?
    hashed_password = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
                                                                     user.password_salt,
                                                                     ITERATIONS,
                                                                     DIGEST.length,
                                                                     DIGEST))

    return user if user.password_hash == hashed_password
    nil
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  private

  def downcase_params
    username&.downcase!
    email&.downcase!
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(self.password,
                                                                          self.password_salt,
                                                                          ITERATIONS,
                                                                          DIGEST.length,
                                                                          DIGEST))
    end
  end
end
