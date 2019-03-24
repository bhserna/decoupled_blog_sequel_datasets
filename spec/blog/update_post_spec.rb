module Blog
  RSpec.describe "Update post" do
    def store_with(records)
      FakeStore.new(records)
    end

    def edit_post_form(id, store)
      Blog.edit_post_form(id, store)
    end

    def update_post(id, params, store)
      Blog.update_post(id, params, store)
    end

    attr_reader :store, :post_id

    before do
      @store = store_with([
        post_with(
          id: @post_id = 1,
          title: "P1",
          body: "Body...",
          description: "Desc...")])
    end


    describe "form..." do
      it "has some attrs..." do
        form = edit_post_form(post_id, store)
        expect(form).to have_attributes(
          title: "P1",
          body: "Body...",
          description: "Desc..."
        )
      end

      it "has no errors" do
        form = edit_post_form(post_id, store)
        expect(form.errors).to be_empty
      end
    end

    describe "with good attrs..." do
      attr_reader :params

      before do
        @params = {
          "title" => "p1",
          "body" => "P1 Body...",
          "description" => "P1 Desc..." }
      end

      it "returns success" do
        status = update_post(post_id, params, store)
        expect(status).to be_success
      end

      it "updates the record" do
        expect(store).to receive(:update).with(post_id, {
          title: "p1",
          body: "P1 Body...",
          description: "P1 Desc..."})
        update_post(post_id, params, store)
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
        status = update_post(post_id, params, store)
        expect(status).not_to be_success
      end

      it "does not create a record" do
        expect(store).not_to receive(:update)
        update_post(post_id, params, store)
      end

      it "returns the other given values" do
        status = update_post(post_id, params, store)
        expect(status.form).to have_attributes(
          title: "",
          body: "Body...",
          description: "Desc..."
        )
      end

      it "returns an empty error" do
        status = update_post(post_id, params, store)
        expect(status.form.errors[:title]).to eq ["can't be blank"]
      end
    end
  end
end
