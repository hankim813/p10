class User < ActiveRecord::Base
  validates :first_name, :last_name, :nickname, :email, :password_hash, :birthday, presence: true

  belongs_to :family
  has_many :posts
  has_many :comments
  has_many :tags
  has_many :polls
  has_many :votes, foreign_key: :voter_id
  has_many :albums
  has_many :photos

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
