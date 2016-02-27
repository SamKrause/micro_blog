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
  erb :user
end

get '/other_user' do
  erb :other_user
end

get '/sign_up' do
  erb :sign_up
end

#Home Methods
post '/newUser' do
  User.create(fname: params["fname"], lname: params["lname"], email: params["email"], handle: params["handle"], password: params["password"])
  redirect "/user"
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
