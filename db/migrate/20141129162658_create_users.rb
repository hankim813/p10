  class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :family
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.boolean :admin, default: false
      t.string :email
      t.string :phone
      t.string :address
      t.string :state
      t.string :country
      t.date :birthday
      t.string :password_hash

      t.timestamps
    end
  end
end
