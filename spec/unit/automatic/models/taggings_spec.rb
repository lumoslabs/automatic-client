require 'spec_helper'

describe Automatic::Models::Taggings do
  let(:tagging_file) do
    File.read(File.expand_path('../../../../data/tagging.json', __FILE__))
  end

  let(:tagging) do
    MultiJson.load(tagging_file)
  end

  let(:collection) { [tagging] }

  subject { described_class.new(collection) }

  context "with no records" do
    let(:collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be(false)
    end
  end

  context "with a single record" do
    it "returns 1 for the #count" do
      expect(subject.count).to eq(1)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be(true)
    end
  end

  context "with 10 records" do
    let(:collection) { (1..10).map { tagging } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be(true)
    end
  end
end
