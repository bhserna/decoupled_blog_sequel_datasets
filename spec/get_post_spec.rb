module Blog
  RSpec.describe "Get post" do
    def store_with(records)
      Store.new(records)
    end

    def post_with(attrs)
      Post.new(attrs)
    end

    def get_post(id, store)
      Blog.get_post(id, store)
    end

    it "return the post with the give id" do
      store = store_with([post_with(id: 1), post_with(id: 2)])
      post = get_post(1, store)
      expect(post.id).to eq 1
    end

    it "returns a post with some attrs..." do
      store = store_with([
        post_with(
          id: 1,
          title: "Post 1",
          description: "Desc...",
          published_on: Date.new(2019, 2, 18))])
      post = get_post(1, store)
      expect(post).to have_attributes(
        id: 1,
        title: "Post 1",
        description: "Desc...",
        published_on: Date.new(2019, 2, 18)
      )
    end
  end
end
