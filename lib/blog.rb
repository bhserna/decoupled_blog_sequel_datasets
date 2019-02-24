require "date"
require "securerandom"

module Blog
  def self.list_posts(store)
    store.all.sort_by(&:created_at).reverse
  end

  def self.get_post(id, store)
    store.find(id)
  end

  def self.new_post_form
    PostForm.new
  end

  def self.create_post(params, store, current_time = Time.now)
    ProcessPostForm.(params) do |form|
      store.create(form.to_h.merge(created_at: current_time))
    end
  end

  def self.edit_post_form(id, store)
    PostForm.new(store.find(id))
  end

  def self.update_post(post_id, params, store)
    ProcessPostForm.(params) do |form|
      store.update(post_id, form.to_h)
    end
  end

  def self.delete_post(post_id, store)
    store.destroy(post_id)
  end

  class ProcessPostForm
    def self.call(params, &block)
      form = PostForm.new(params)
      form.validate!

      if form.valid?
        block.call(form)
        SuccessStatus
      else
        ErrorStatus.new(form)
      end
    end
  end

  class ErrorStatus
    attr_reader :form

    def initialize(form)
      @form = form
    end

    def success?
      false
    end
  end

  class SuccessStatus
    def self.success?
      true
    end
  end

  class PostForm
    attr_reader :title, :body, :description, :errors

    def initialize(source = {})
      @errors = {}
      @title = extract(source, :title)
      @description = extract(source, :description)
      @body = extract(source, :body)
    end

    def to_h
      { title: title,
        description: description,
        body: body }
    end

    def validate!
      if title.empty?
        errors[:title] = ["can't be blank"]
      end
    end

    def valid?
      errors.empty?
    end

    private

    def extract(source, key)
      if source.respond_to?(key)
        source.send(key)
      else
        source[key.to_s]
      end
    end
  end

  class Post
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

  class Store
    attr_reader :all

    def initialize(records = [])
      @all = records
    end

    def update(id, attrs)
      @all = all.map do |record|
        if has_id?(record, id)
          update_record(record, attrs)
        else
          record
        end
      end
    end

    def create(attrs)
      all << Post.new(attrs.merge(id: SecureRandom.uuid))
    end

    def destroy(id)
      @all = all.reject { |record| has_id?(record, id) }
    end

    def find(id)
      all.find { |record| has_id?(record, id) } || :no_record
    end

    private

    def has_id?(record, id)
      record.id.to_s == id.to_s
    end

    def update_record(record, attrs)
      Post.new(record.attributes.merge(attrs))
    end
  end
end
