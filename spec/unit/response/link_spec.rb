require 'spec_helper'

describe Automatic::Client::Response::Link do
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
      expect(subject.next?).to be_true
    end

    it "returns false for #previous?" do
      expect(subject.previous?).to be_false
    end

    describe "#next?" do
      it "returns true if this is a next link" do
        expect(subject.next?).to be_true
      end

      it "returns false if this is not a next link" do
        attributes[:rel] = 'previous'
        expect(subject.next?).to be_false
      end
    end

    describe "#previous?" do
      it "returns true if this is a previous link" do
        attributes[:rel] = 'previous'
        expect(subject.previous?).to be_true
      end

      it "returns false if this is not a previous link" do
        expect(subject.previous?).to be_false
      end
    end
  end
end
