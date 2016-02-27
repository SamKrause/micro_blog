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

  def following
    followingIds = FollowerFollowed.where(:follower_id => self.id).pluck(:followed_id)
    followingArray = []
    followingIds.each do |id|
      followingArray.push User.find(id)
    end
    return followingArray
  end
end

