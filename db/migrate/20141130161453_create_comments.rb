class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :parent, default: nil
      t.belongs_to :user
      t.text :description
      t.belongs_to :commentable, polymorphic: true

      t.timestamps
    end
  end
end
