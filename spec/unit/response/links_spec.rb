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

  describe "#previous" do
    let(:collection) do
      [
        { uri: 'testing-prev.com', rel: 'previous' }
      ]
    end

    it "returns the Previous link uri" do
      expect(subject.previous.uri).to eq('testing-prev.com')
    end

    it "returns true for #previous?" do
      expect(subject.previous?).to be_true
    end
  end

  describe "#next" do
    let(:collection) do
      [
        { uri: 'testing-next.com', rel: 'next' }
      ]
    end

    it "returns the Next link uri" do
      expect(subject.next.uri).to eq('testing-next.com')
    end

    it "returns true for #next?" do
      expect(subject.next?).to be_true
    end
  end

  describe "#first_page" do
    let(:collection) do
      [
        { uri: 'testing-first-page.com', rel: 'first' }
      ]
    end

    it "returns the First link uri" do
      expect(subject.first_page.uri).to eq('testing-first-page.com')
    end

    it "returns true for #first_page?" do
      expect(subject.first_page?).to be_true
    end
  end

  describe "#last_page" do
    let(:collection) do
      [
        { uri: 'testing-last-page.com', rel: 'last' }
      ]
    end

    it "returns the Last link uri" do
      expect(subject.last_page.uri).to eq('testing-last-page.com')
    end

    it "returns true for #last_page?" do
      expect(subject.last_page?).to be_true
    end
  end
end
