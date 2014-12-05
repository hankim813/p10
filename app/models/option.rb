class Option < ActiveRecord::Base
  belongs_to :poll
  has_many :votes
  has_many :backers, class_name: "Vote", foreign_key: :voter_id
end
