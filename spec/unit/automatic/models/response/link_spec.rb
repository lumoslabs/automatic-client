require 'spec_helper'

describe Automatic::Models::Response::Link do
  let(:attributes) do
    {
      :uri => 'www.testing.com',
      :rel => 'next'
    }
  end

  subject { described_class.new(attributes) }

  context "with all params" do
    it "returns the #uri" do
      expect(subject.uri).to eq('www.testing.com')
    end

    it "returns the #rel" do
      expect(subject.rel).to eq('next')
    end

    it "returns true for #next?" do
      expect(subject.next?).to be(true)
    end

    it "returns false for #previous?" do
      expect(subject.previous?).to be(false)
    end

    describe "#next?" do
      it "returns true if this is a next link" do
        expect(subject.next?).to be(true)
      end

      it "returns false if this is not a next link" do
        attributes[:rel] = 'previous'
        expect(subject.next?).to be(false)
      end
    end

    describe "#previous?" do
      it "returns true if this is a previous link" do
        attributes[:rel] = 'previous'
        expect(subject.previous?).to be(true)
      end

      it "returns false if this is not a previous link" do
        expect(subject.previous?).to be(false)
      end
    end

    describe "#last?" do
      it "returns true if this is a last link" do
        attributes[:rel] = 'last'
        expect(subject.last?).to be(true)
      end

      it "returns false if this is not a last link" do
        expect(subject.last?).to be(false)
      end
    end

    describe "#first?" do
      it "returns true if this is a first link" do
        attributes[:rel] = 'first'
        expect(subject.first?).to be(true)
      end

      it "returns false if this is not a first link" do
        expect(subject.first?).to be(false)
      end
    end
  end
end
