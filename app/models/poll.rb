class Poll < ActiveRecord::Base
  belongs_to :user
  belongs_to :winner, class_name: "Option", foreign_key: :winner_id
  has_many :options
  has_and_belongs_to_many :tags

  validates :question, presence: true
end
