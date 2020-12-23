require 'openssl'

class User < ApplicationRecord

  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  has_many :questions

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  attr_accessor :password

  # валидация будет проходить только при создании нового юзера
  validates :password, presence: true, on: :create

  # поле подтверждения пароля
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )

    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    # находим кандидата по email
    user = find_by(email: email)

    # Если пользователь не найден, возвращает nil
    return nil unless user.present?

    # Формируем хэш пароля из того, что передали в метод
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end
