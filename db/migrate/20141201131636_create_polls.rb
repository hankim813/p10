class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.belongs_to :user
      t.string :question
      t.text :description
      t.boolean :expired, default: false
      t.references :winner

      t.timestamps
    end
  end
end
