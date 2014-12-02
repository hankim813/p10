class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.text :description
      t.text :parsed_html

      t.timestamps
    end
  end
end
