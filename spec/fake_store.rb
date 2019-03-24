class FakeStore
  attr_reader :all

  def initialize(records = [])
    @all = records
  end

  def update(id, attrs)
  end

  def create(attrs)
  end

  def destroy(id)
  end

  def find(id)
    all.find { |record| has_id?(record, id) } || :no_record
  end

  private

  def has_id?(record, id)
    record.id.to_s == id.to_s
  end
end
