class CreatePhotosTags < ActiveRecord::Migration
  def change
  	create_table :photos_tags, id: false do |t|
  		t.belongs_to :photo
  		t.belongs_to :tag
  	end
  end
end
