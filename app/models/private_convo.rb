class PrivateConvo < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipient, class_name: "User", foreign_key: :recipient_id
	has_many :messages
end
