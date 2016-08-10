class RemoveUpVoteColumnFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :up_vote
  end
end
