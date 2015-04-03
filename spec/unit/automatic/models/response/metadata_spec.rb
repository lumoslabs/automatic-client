require 'spec_helper'

describe Automatic::Models::Response::Metadata do
  let(:metadata_file) do
    File.read(File.expand_path('../../../../../data/_metadata.json', __FILE__))
  end

  let(:metadata) do
    MultiJson.load(metadata_file)
  end

  let(:attributes) { metadata }

  subject { described_class.new(attributes) }

  context "when there are items in the collection" do
    it "returns the #count of pages in the collection" do
      expect(subject.count).to eq(100)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end

  context "when there are no items in the collection" do
    before(:each) do
      attributes['count'] = 0
    end

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be(false)
    end
  end

  describe "#next" do
    context "when there is a next set in the collection" do
      it "returns the #next URL" do
        expect(subject.next).to eq("https://api.automatic.com/?next=1")
      end

      it "returns true for #next?" do
        expect(subject.next?).to be_true
      end
    end

    context "when there is not a next set in the collection" do
      before(:each) do
        attributes['next'] = nil
      end

      it "returns nil for the #next URL" do
        expect(subject.next).to be_nil
      end

      it "returns false for #next?" do
        expect(subject.next?).to be(false)
      end
    end
  end

  describe "#previous" do
    context "when there is a previous set in the collection" do
      it "returns the #previous URL" do
        expect(subject.previous).to eq("https://api.automatic.com/?previous=1")
      end

      it "returns true for #previous?" do
        expect(subject.previous?).to be_true
      end
    end

    context "when there is not a previous set in the collection" do
      before(:each) do
        attributes['previous'] = nil
      end

      it "returns nil for the #previous URL" do
        expect(subject.previous).to be_nil
      end

      it "returns false for #previous?" do
        expect(subject.previous?).to be(false)
      end
    end
  end
end
