module Blog
  RSpec.describe "Create post" do
    def empty_store
      Store.new
    end

    def new_post_form
      Blog.new_post_form
    end

    def create_post(params, store)
      Blog.create_post(params, store, current_time)
    end

    def current_time
      @current_time ||= Time.now
    end

    describe "form..." do
      it "has some attrs..." do
        form = new_post_form
        expect(form).to have_attributes(
          title: nil,
          body: nil,
          description: nil
        )
      end

      it "has no errors" do
        form = new_post_form
        expect(form.errors).to be_empty
      end
    end

    describe "with good attrs..." do
      attr_reader :params

      before do
        @params = {
          "title" => "P1",
          "body" => "Body...",
          "description" => "Desc..." }
      end

      it "returns success" do
        store = empty_store
        status = create_post(params, store)
        expect(status).to be_success
      end

      it "creates a record" do
        store = empty_store
        expect(store).to receive(:create).with(
          title: "P1",
          body: "Body...",
          description: "Desc...",
          created_at: current_time)
        create_post(params, store)
      end
    end

    describe "with an empty title..." do
      attr_reader :params

      before do
        @params = {
          "title" => "",
          "body" => "Body...",
          "description" => "Desc..." }
      end

      it "does not returns success" do
        store = empty_store
        status = create_post(params, store)
        expect(status).not_to be_success
      end

      it "does not create a record" do
        store = empty_store
        expect(store).not_to receive(:create)
        create_post(params, store)
      end

      it "returns the other given values" do
        store = empty_store
        status = create_post(params, store)
        expect(status.form).to have_attributes(
          title: "",
          body: "Body...",
          description: "Desc..."
        )
      end

      it "returns an empty error" do
        store = empty_store
        status = create_post(params, store)
        expect(status.form.errors[:title]).to eq ["can't be blank"]
      end
    end
  end
end
