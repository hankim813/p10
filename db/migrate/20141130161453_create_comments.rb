class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.belongs_to :parent, default: nil
      t.belongs_to :user
      t.text :description

      t.timestamps
    end
  end
end
