require 'spec_helper'

describe Automatic::Client::Response::Links do
  let(:collection) do
    [
      { uri: 'testing.com', rel: 'next' }
    ]
  end

  subject { described_class.new(collection) }

  context "with no records" do
    let(:collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_false
    end
  end

  context "with a single record" do
    it "returns 1 for the #count" do
      expect(subject.count).to eq(1)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end

  context "with 10 records" do
    let(:collection) { (1..10).map { { uri: 'testing.com', rel: 'self' } } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end
end
