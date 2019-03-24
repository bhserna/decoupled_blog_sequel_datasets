module Blog
  RSpec.describe "Delete post" do
    def store_with(records)
      FakeStore.new(records)
    end

    def delete_post(id, store)
      Blog.delete_post(id, store)
    end

    it "destroys the record" do
      store = store_with([post_with(id: post_id = 1)])
      expect(store).to receive(:destroy).with(post_id)
      delete_post(post_id, store)
    end
  end
end
