require 'spec_helper'

describe Automatic::Client::Response::LinkHeader do
  let(:header) do
    '<https://api.automatic.com/v1/trips?page=3&per_page=100>; rel="next",
    <https://api.automatic.com/v1/trips?page=27&per_page=100>; rel="last"'
  end

  subject { described_class.new(header) }

  context "with valid header" do
    it "returns 2 for the #count" do
      expect(subject.count).to eq(2)
    end

    it "returns true for #any?" do
      expect(subject.any?).to eq(true)
    end
  end

  context "with a single link" do
    let(:header) do
      '<https://api.automatic.com/v1/trips?page=3&per_page=100>; rel="next"'
    end

    it "returns 1 for the #count" do
      expect(subject.count).to eq(1)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end

  context "with an invalid header" do
    let(:header) { 'invalid' }

    it "raises an InvalidLinkHeaderError" do
      lambda { subject.count }.should raise_error(Automatic::Client::Response::LinkHeader::InvalidLinkHeaderError)
    end
  end

  context "with an empty header" do
    let(:header) { '' }

    it "returns 0 for the #count" do
      expect(subject.count).to eql(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_false
    end
  end

  context "with a nil header" do
    let(:header) { nil }

    it "returns 0 for the #count" do
      expect(subject.count).to eql(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_false
    end
  end
end
