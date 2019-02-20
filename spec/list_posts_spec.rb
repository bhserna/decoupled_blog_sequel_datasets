module Blog
  RSpec.describe "List posts" do
    def store_with(records)
      Store.new(records)
    end

    def post_with(attrs)
      Post.new(attrs)
    end

    def list_posts(store)
      Blog.list_posts(store)
    end

    it "returns all posts" do
      store = store_with([post_with(id: 1), post_with(id: 2)])
      posts = list_posts(store)
      expect(posts.count).to eq 2
    end

    describe "each post..." do
      it "has some attrs..." do
        store = store_with([
          post_with(
            id: 1,
            title: "Post 1",
            description: "Short desc...",
            published_on: Date.new(2019, 2, 18))])
        post = list_posts(store).first
        expect(post).to have_attributes(
          id: 1,
          title: "Post 1",
          description: "Short desc...",
          published_on: Date.new(2019, 2, 18)
        )
      end
    end
  end
end
