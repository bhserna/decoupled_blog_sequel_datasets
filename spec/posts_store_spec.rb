require_relative "../lib/store"

RSpec.describe Store::Post do
  let(:store) { Store::Post }
  it { expect(store).to respond_to(:all) }
  it { expect(store).to respond_to(:find) }
  it { expect(store).to respond_to(:create) }
  it { expect(store).to respond_to(:update) }
  it { expect(store).to respond_to(:destroy) }
end
