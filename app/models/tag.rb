class Tag < ActiveRecord::Base
  validates :word, presence: true 
  belongs_to :user
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :polls
end