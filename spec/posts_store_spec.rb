require "posts_store_shared_specs"

module Blog
  RSpec.describe Store do
    it_behaves_like "Posts store"
  end
end
