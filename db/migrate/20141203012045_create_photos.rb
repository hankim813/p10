class CreatePhotos < ActiveRecord::Migration
  def change
  	create_table :photos do |t|
  		t.belongs_to :user
  		t.belongs_to :album
  		t.string :src
  		t.string :caption
  		t.string :location
  		
  		t.timestamps
  	end
  end
end
