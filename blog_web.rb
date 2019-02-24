require "sinatra"
require "hamlit"
require_relative "lib/blog"

posts = (1..5).map do |id|
  Blog::Post.new(
    id: SecureRandom.uuid,
    title: "Lorem ipsum dolor sit amet",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud",
    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    created_at: Time.now)
end

store = Blog::Store.new(posts)

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
