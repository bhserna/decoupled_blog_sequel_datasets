class FakePost
  attr_reader :id, :title, :body, :description, :created_at

  def initialize(attrs)
    @id = attrs[:id]
    @title = attrs[:title]
    @description = attrs[:description]
    @created_at = attrs[:created_at]
    @body = attrs[:body]
  end

  def attributes
    [:id, :title, :body, :description, :created_at].map do |key|
      [key, send(key)]
    end.to_h
  end
end
