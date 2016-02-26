class User < ActiveRecord::Base
  has_many :posts
  has_many :followers_followeds
end
