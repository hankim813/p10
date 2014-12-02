class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :options
  belongs_to :winner, class_name: "Option", foreign_key: :winner_id

  validates :question, presence: true
end
