require "sinatra"
require "hamlit"
require_relative "lib/blog"
require_relative "lib/store"

store = Store::Post

get "/" do
  posts = Blog.list_posts(store)
  haml :index, locals: { posts: posts }
end

get "/posts/new" do
  form = Blog.new_post_form
  haml :new, locals: { form: form }
end

post "/posts" do
  status = Blog.create_post(params, store)

  if status.success?
    redirect to("/")
  else
    haml :new, locals: { form: status.form }
  end
end

get "/posts/:id" do |id|
  post = Blog.get_post(id, store)
  haml :show, locals: { post: post }
end

get "/posts/:id/edit" do |id|
  form = Blog.edit_post_form(id, store)
  haml :edit, locals: { form: form, post_id: id }
end

put "/posts/:id" do |id|
  status = Blog.update_post(id, params, store)

  if status.success?
    redirect to("/")
  else
    haml :edit, locals: { form: status.form, post_id: id }
  end
end

delete "/posts/:id" do |id|
  Blog.delete_post(id, store)
  redirect to("/")
end
