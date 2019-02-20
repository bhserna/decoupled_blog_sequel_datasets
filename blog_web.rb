require "sinatra"
require "hamlit"
require_relative "lib/blog"

store = Blog::Store.new([
  Blog::Post.new(id: 1, title: "My post", description: "hola", body: "mundo")
])

get "/" do
  posts = Blog.list_posts(store)
  haml :index, locals: { posts: posts }
end

get "/posts/new" do
  form = Blog.new_post_form
  haml :new, locals: { form: form }
end

post "/posts" do
  Blog.create_post(params, store)
  redirect to("/")
end

get "/posts/:id" do |id|
  post = Blog.get_post(id, store)
  haml :show, locals: { post: post }
end

get "/posts/:id/edit" do |id|
  form = Blog.edit_post_form(id, store)
  haml :edit, locals: { form: form }
end

put "/posts/:id" do |id|
  Blog.update_post(id, params, store)
  redirect to("/")
end

delete "/posts/:id" do |id|
  Blog.delete_post(id, store)
  redirect to("/")
end
