require_relative "../db/config"

module Store
  class Post < Sequel::Model
    def self.find(id)
      first(id: id)
    end

    def self.update(id, attrs)
      find(id).update(attrs)
    end

    def self.destroy(id)
      find(id).destroy
    end
  end
end
