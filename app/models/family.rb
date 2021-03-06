class Family < ActiveRecord::Base
  validates :name, :slogan, :hometown, :homestate, :homecountry, presence: true

  has_many :users
  has_many :posts, through: :users
  has_many :polls, through: :users
  has_many :tags, through: :users
  has_many :comments, through: :users
  has_many :options, through: :polls
  has_many :votes, through: :options
  has_many :photos, through: :users
  has_many :albums, through: :users
  has_many :messages, through: :users

  include BCrypt

  def password
    @password ||= Password.new(token)
  end

  def password=(id)
    @password = Password.create(id)
    self.token = @password
  end

  def authenticate(family_key)
    self.password == family_key
  end
end
