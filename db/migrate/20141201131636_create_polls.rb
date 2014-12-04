class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.belongs_to :user
      t.string :question
      t.text :description

      t.timestamps
    end
  end
end
