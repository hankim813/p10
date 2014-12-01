class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :vote_count
      t.text :description
      t.belongs_to :poll

      t.timestamps
    end
  end
end
