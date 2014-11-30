class Family < ActiveRecord::Base
  validates :name, :slogan, :hometown, :homestate, :homecountry, presence: true

  has_many :users
end
