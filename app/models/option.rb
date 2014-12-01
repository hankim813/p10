class Option < ActiveRecord::Base
  belongs_to :poll
  has_many :voters, through: :votes, source: :voter
end
