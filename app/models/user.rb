class User < ActiveRecord::Base
  validates :first_name, :last_name, :nickname, :email, :password_hash, :birthday, presence: true

  belongs_to :family
  has_many :posts
  has_many :comments

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(plaintext)
    @password = Password.create(plaintext)
    self.password_hash = @password
  end

  def authenticate(plaintext)
    self.password == plaintext
  end
end
