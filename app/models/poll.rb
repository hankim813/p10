class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :options
  has_many :comments, as: :commentable
  has_and_belongs_to_many :tags

  validates :question, presence: true
end
