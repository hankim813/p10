class CreateAlbums < ActiveRecord::Migration
  def change
  	create_table :albums do |t|
  		t.string :title
  		t.text :description
  		t.string :location
  		t.belongs_to :user

  		t.timestamps
  	end
  end
end
