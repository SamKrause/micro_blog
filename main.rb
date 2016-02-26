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
#set :sessions, true
#needed for flash
#enable :sessions


get '/' do
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
