  class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :family
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :profile_pic_link
      t.boolean :admin, default: false
      t.string :email
      t.string :phone
      t.string :address
      t.string :state
      t.string :country
      t.string :birthday
      t.string :password_hash
      t.string :family_key

      t.timestamps
    end
  end
end
