class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :replies, class_name: "Comment", foreign_key: :parent_id
  belongs_to :parent_comment, class_name: "Comment", foreign_key: :parent_id

  validates :description, presence: true
end
