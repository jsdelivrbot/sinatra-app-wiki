require "sinatra"

#if not running on local computer
#set :bind, "0.0.0.0"

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT #if file isn't there, we just won't get anything back  
  return nil
end

get "/" do
  # erb loads from "views" directory by default with filename as a symbol
  erb :welcome
end

get "/:title" do
  @title = params[:title] #declare instance variable
  @content = page_content(@title)
  erb :show
end 