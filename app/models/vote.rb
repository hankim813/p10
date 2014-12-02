class Vote < ActiveRecord::Base
  belongs_to :backer, class_name: "User", foreign_key: :voter_id
  belongs_to :option
end
