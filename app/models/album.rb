class Album < ActiveRecord::Base
	belongs_to :user
	has_many :photos
	has_and_belongs_to_many :tags
	has_many :comments, as: :commentable
end
