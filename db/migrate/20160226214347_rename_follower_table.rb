class RenameFollowerTable < ActiveRecord::Migration
  def change
    rename_table :folowers_followeds, :follower_followeds
  end
end
