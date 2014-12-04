class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_one :parent_comment, class_name: "Comment", as: :commentable
  has_many :replies, class_name: "Comment", foreign_key: :commentable_id

  validates :description, presence: true
end


