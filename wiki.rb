require "sinatra"
require "uri"

#if not running on local computer, uncomment below line

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT #if file isn't there, we just won't get anything back  
  return nil
end

def save_content(title, content) #creates new file, or updates existing file
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

def delete_content(title)
  File.delete("pages/#{title}.txt")
end

get "/" do
  @posts_arr = []
  d = Dir.new("pages")
  d.each  do |file| 
    next if file == '.' or file == '..'
    @posts_arr << file.chomp(".txt")
  end
  # erb loads from "views" directory by default with filename as a symbol
  erb :welcome
  # erb :welcome, layout: :templatename # uncomment this line if you want to specify a specific template, other than default.
end

get "/new" do
  erb :new
end

#{"title"=>"New Page", "content"=>"Hello world!"}
post "/create" do
  save_content(params[:title], params[:content])
  redirect URI.escape("/#{params[:title]}")
end

delete "/:title" do
  delete_content(params[:title])
  redirect "/"
end

get "/:title" do
  @title = params[:title] #declare instance variable
  @content = page_content(@title)
  erb :show
end

put "/:title" do
  save_content(params[:title], params[:content])
  redirect URI.escape("/#{params[:title]}")
end

get "/:title/edit" do
  @title = params[:title]
  @content = page_content(@title)
  erb :edit
end

