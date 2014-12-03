class CreateAlbumsTags < ActiveRecord::Migration
  def change
  	create_table :albums_tags, id: false do |t|
  		t.belongs_to :album
  		t.belongs_to :tag
  	end
  end
end
