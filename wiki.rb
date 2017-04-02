require "sinatra"

#if not running on local computer
#set :bind, "0.0.0.0"

get "/" do
  # erb loads from views directory
  erb :welcome
end