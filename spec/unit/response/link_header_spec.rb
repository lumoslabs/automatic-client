require 'spec_helper'

describe Automatic::Client::Response::LinkHeader do
  let(:header) do
    '<https://api.automatic.com/v1/trips?page=3&per_page=100>; rel="next",
    <https://api.automatic.com/v1/trips?page=27&per_page=100>; rel="last"'
  end

  subject { described_class.new(header) }

  context "with links" do
    it "returns a Links object" do
      expect(subject.links).to be_a(Automatic::Client::Response::Links)
    end

    it "returns true for #links?" do
      expect(subject.links?).to be_true
    end
  end

  context "without links" do
    let(:header) { '' }

    it "returns a Links object" do
      expect(subject.links).to be_a(Automatic::Client::Response::Links)
    end

    it "returns false for #links?" do
      expect(subject.links?).to be_false
    end
  end

end
