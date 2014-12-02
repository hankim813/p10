class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.string :slogan
      t.string :hometown
      t.string :homestate
      t.string :homecountry
      t.string :cover_photo_link
      t.string :token

      t.timestamps
    end
  end
end
