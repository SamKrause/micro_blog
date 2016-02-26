class User < ActiveRecord::Base
  has_many :posts

  def followers
    followerIds = FollowerFollowed.where(:followed_id => self.id).pluck(:follower_id)
    followersArray = []
    followerIds.each do |id|
     followersArray.push User.find(id)
    end
    return followersArray
  end
end

