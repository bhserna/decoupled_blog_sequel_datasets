module Blog
  RSpec.shared_examples "Posts store" do
    it { expect(subject).to respond_to(:all) }
    it { expect(subject).to respond_to(:find) }
    it { expect(subject).to respond_to(:create) }
    it { expect(subject).to respond_to(:update) }
    it { expect(subject).to respond_to(:destroy) }

    describe "create" do
      it "saves a record" do
        subject.create(title: "A", body: "B", description: "C")

        records = subject.all
        record = records.first

        expect(records.count).to eq 1
        expect(record.id).to be
        expect(record.title).to eq "A"
        expect(record.body).to eq "B"
        expect(record.description).to eq "C"
      end
    end

    describe "find" do
      it "with id" do
        subject.create(title: "A", body: "B", description: "C")
        records = subject.all
        record = records.first

        finded = subject.find(record.id)
        expect(record.id).to eq finded.id
      end

      it "with id as string" do
        subject.create(title: "A", body: "B", description: "C")
        records = subject.all
        record = records.first

        finded = subject.find(record.id.to_s)
        expect(record.id).to eq finded.id
      end
    end

    describe "update" do
      it "updates the record" do
        subject.create(title: "A", body: "B", description: "C")

        records = subject.all
        record = records.first

        subject.update(record.id, title: "AA", body: "BB", description: "CC")

        records = subject.all
        record = records.first

        expect(records.count).to eq 1
        expect(record.id).to be
        expect(record.title).to eq "AA"
        expect(record.body).to eq "BB"
        expect(record.description).to eq "CC"
      end
    end

    describe "destroy" do
      it "removes the record" do
        subject.create(title: "A", short_description: "B", description: "C")

        records = subject.all
        record = records.first

        subject.destroy(record.id)

        records = subject.all
        expect(records.count).to eq 0
      end
    end
  end
end
