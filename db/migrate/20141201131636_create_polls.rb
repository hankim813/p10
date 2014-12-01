class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.belongs_to :user
      t.text :question
      t.references :winner

      t.timestamps
    end
  end
end
