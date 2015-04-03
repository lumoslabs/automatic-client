require 'spec_helper'

describe Automatic::Utilities::StatusCodeMapper do
  let(:codes) { [:success, 200, 202] }

  subject { described_class.new(codes) }

  context "constants" do
    it "returns a STATUS_MAP" do
      expect(described_class::STATUS_MAP).to be_a(Hash)
    end
  end

  it "returns the collection of codes" do
    expected = (200...300).to_a
    expect(subject.codes).to eq(expected)
  end

  it "ensures only unique codes are returned" do
    status_codes = [200, 200]

    expect(described_class.new(status_codes).codes).to eq([200])
  end

  context "symbols" do
    it "returns the set of successful status codes" do
      expected = (200...300).to_a

      expect(described_class.new(:success).codes).to eq(expected)
    end

    it "returns distinct codes with symbols and strings are used" do
      expected_count = (200...300).to_a.count
      expect(described_class.new(:success, 200).codes.count).to eq(expected_count)
    end
  end

  context "inclusion" do
    it "returns true for 204" do
      expect(subject.includes?(204)).to be(true)
    end

    it "returns false for 301" do
      expect(subject.includes?(301)).to be(false)
    end

    it "returns true for string of 202" do
      expect(subject.includes?('202')).to be(true)
    end
  end
end

