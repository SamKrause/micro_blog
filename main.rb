require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/flash'
configure(:development){set :database, "sqlite3:nycda_test.sqlite3"}

#the requires for the models
require './models/users'
require './models/posts'
require './models/followers_followeds'

#needed for sessions
set :sessions, true
#needed for flash
enable :sessions


get '/' do
  loggedIn
  @posts = Post.all
  erb :home
end

get '/user' do
  loggedIn
  @posts = Post.where(:user_id => @user.id).all
  @following = FollowerFollowed.where(:follower_id => @user.id)
  @followers = FollowerFollowed.where(:followed_id => @user.id)
  erb :user
end

post '/other_user' do
  loggedIn
  if @user
    @other_user = User.find_by(handle: params["other_user_handle"])
    @posts = Post.where(:user_id => @other_user.id).all
    @following = FollowerFollowed.where(:follower_id => @other_user.id)
    @followers = FollowerFollowed.where(:followed_id => @other_user.id)
    erb :other_user
  else
    redirect to '/'
  end
end

get '/sign_up' do
  erb :sign_up
end
get '/login' do
  erb :login
end
#Home Methods
post '/newUser' do
  User.create(fname: params["fname"], lname: params["lname"], email: params["email"], handle: params["handle"], password: params["password"])
  user = User.find_by(handle: params["handle"])
  session[:user_id] = user.id
  redirect to "/user"
end

post '/login' do
  user = User.find_by(handle: params["handle"])
  if user && user.password == params["password"]
    session[:user_id] = user.id
    redirect to '/'
  else
    redirect to '/'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

post '/follow_other_user' do
  loggedIn
  if FollowerFollowed.find_by(follower_id: @user.id, followed_id: params["followed_id"]).nil?
    FollowerFollowed.create(follower_id: @user.id, followed_id: params["followed_id"])
    redirect to '/'
  else
    puts "Already Followed"
    redirect to '/'
  end
end

post '/unfollow_other_user' do
  loggedIn
  if FollowerFollowed.find_by(follower_id: @user.id, followed_id: params["followed_id"]).nil?
    puts "Not Following"
    redirect to '/'
  else
    FollowerFollowed.find_by(follower_id: @user.id, followed_id: params["followed_id"]).destroy
    redirect to '/'
  end
end

#User Page Methods
post '/newPost' do
  loggedIn
  Post.create(user_id: @user.id, message: params["message"], created_at: Time.now)
  redirect "/user"
end

post '/editUser' do
  loggedIn
  User.update(@user.id, :fname => params["fname"], :lname => params["lname"], :email => params["email"], :handle => params["handle"], :password => params["password"])
  redirect "/user"
end

post '/deleteUser' do
  loggedIn
  Post.where(:user_id => @user.id).destroy_all
  FollowerFollowed.where(:follower_id => @user.id).destroy_all
  FollowerFollowed.where(:followed_id => @user.id).destroy_all
  User.find(@user.id).destroy
  session[:user_id] = nil
  redirect '/'
end

#Other User Page Methods


#Universal Methods
def loggedIn
  @user = current_user
end

def current_user
  if session[:user_id]
    User.find(session[:user_id])
  else
    nil
  end
end

