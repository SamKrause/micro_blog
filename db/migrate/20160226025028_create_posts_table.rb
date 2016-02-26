class CreatePostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :message
      t.timestamp :created_at, default: Time.now
    end
  end
end
