module Blog
  RSpec.describe "List posts" do
    def store_with(records)
      FakeStore.new(records)
    end

    def list_posts(store)
      Blog.list_posts(store)
    end

    def hours(seconds)
      seconds * 60 * 60
    end

    def current_time
      @current_time ||= Time.now
    end

    it "returns all posts" do
      store = store_with([post_with(id: 1), post_with(id: 2)])
      posts = list_posts(store)
      expect(posts.count).to eq 2
    end

    it "returns all posts sorted by creation" do
      store = store_with([
        post_with(id: "first", created_at: current_time - hours(2)),
        post_with(id: "second", created_at: current_time)
      ])
      posts = list_posts(store)
      expect(posts.map(&:id)).to eq ["second", "first"]
    end

    describe "each post..." do
      it "has some attrs..." do
        store = store_with([
          post_with(
            id: 1,
            title: "Post 1",
            description: "Short desc...",
            created_at: current_time)])
        post = list_posts(store).first
        expect(post).to have_attributes(
          id: 1,
          title: "Post 1",
          description: "Short desc...",
          created_at: current_time
        )
      end
    end
  end
end
