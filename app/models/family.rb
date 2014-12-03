class Family < ActiveRecord::Base
  validates :name, :slogan, :hometown, :homestate, :homecountry, presence: true

  has_many :users
  has_many :posts, through: :users
  has_many :polls, through: :users
  has_many :tags, through: :users
  has_many :comments, through: :users
  has_many :options, through: :polls
  has_many :votes, through: :options

  include BCrypt

  def password
    @password ||= Password.new(token)
  end

  def password=(id)
    @password = Password.create(id)
    self.token = @password
  end

  def authenticate(family_id)
    self.password == family_id
  end
end
