class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :track, index: true
      t.integer :up_vote
      t.timestamps
    end
  end
end
