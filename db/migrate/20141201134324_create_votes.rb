class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :option
      t.belongs_to :voter

      t.timestamps
    end
  end
end
