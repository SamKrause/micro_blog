class CreateFollowersFollowedsTable < ActiveRecord::Migration
  def change
    create_table :folowers_followeds do |t|
      t.integer :follower_id
      t.integer :followed_id
    end
  end
end
