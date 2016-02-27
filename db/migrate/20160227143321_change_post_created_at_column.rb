class ChangePostCreatedAtColumn < ActiveRecord::Migration
  def change
    change_column :posts, :created_at, :datetime, :default => nil
  end
end
