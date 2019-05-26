require_relative "../db/config"

class Store
  def initialize
    @records = DB[:posts]
  end

  def all
    records.all.map(&method(:build))
  end

  def update(id, attrs)
    records.where(id: id).update(attrs)
  end

  def create(attrs)
    records.insert(attrs)
  end

  def destroy(id)
    records.where(id: id).delete
  end

  def find(id)
    build(records.first(id: id)) || :no_record
  end

  private

  attr :records

  def build(record)
    Blog::Post.new(record)
  end
end
