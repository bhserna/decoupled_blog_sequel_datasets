require_relative "fake_post"

module Factories
  def post_with(attrs)
    FakePost.new(attrs)
  end
end
