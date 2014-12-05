class CreateMessages < ActiveRecord::Migration
  def change
  	create_table :messages do |t|
  		t.belongs_to :recipient
  		t.belongs_to :user
  		t.text :description

  		t.timestamps
  	end
  end
end
