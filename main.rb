require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/flash'
configure(:development){set :database, "sqlite3:nycda_test.sqlite3"}

#needed for sessions
set :sessions, true
#needed for flash
enable :sessions

