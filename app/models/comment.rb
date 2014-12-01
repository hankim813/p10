class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :comment, foreign_key: :reply_id
end
