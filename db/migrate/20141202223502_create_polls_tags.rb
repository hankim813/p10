class CreatePollsTags < ActiveRecord::Migration
  def change
  	create_table :polls_tags, id: false do |t|
  		t.belongs_to :poll
  		t.belongs_to :tag
  	end
  end
end
