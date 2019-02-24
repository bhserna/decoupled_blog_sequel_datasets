module Blog
  RSpec.describe Store do
    let(:store) { Store.new }

    it { expect(store).to respond_to(:all) }
    it { expect(store).to respond_to(:find) }
    it { expect(store).to respond_to(:create) }
    it { expect(store).to respond_to(:update) }
    it { expect(store).to respond_to(:destroy) }

    example "create a record" do
      store.create(title: "A", body: "B", description: "C", created_at: "D")
      record = store.all.first
      expect(record.id).to be
      expect(record.title).to eq "A"
      expect(record.body).to eq "B"
      expect(record.description).to eq "C"
      expect(record.created_at).to eq "D"
    end

    example "fetch all records" do
      store.create(title: "A")
      store.create(title: "B")
      expect(store.all.map(&:title)).to eq ["A", "B"]
    end

    example "find by id" do
      store.create(title: "A", body: "B", description: "C")
      records = store.all
      record = records.first

      finded = store.find(record.id)
      expect(record.id).to eq finded.id
    end

    example "find with id as string" do
      store.create(title: "A", body: "B", description: "C")
      records = store.all
      record = records.first

      finded = store.find(record.id.to_s)
      expect(record.id).to eq finded.id
    end

    example "update a record" do
      store.create(title: "A", body: "B", description: "C")
      record = store.all.first
      store.update(record.id.to_s, title: "AA", body: "BB", description: "CC")

      record = store.find(record.id)
      expect(record.id).to be
      expect(record.title).to eq "AA"
      expect(record.body).to eq "BB"
      expect(record.description).to eq "CC"
    end

    example "destroy a record" do
      store.create(title: "A", short_description: "B", description: "C")
      record = store.all.first
      store.destroy(record.id.to_s)

      records = store.all
      expect(records.count).to eq 0
    end
  end
end
