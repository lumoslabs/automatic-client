require 'spec_helper'

describe Automatic::Models::Tag do
  let(:tag_file) do
    File.read(File.expand_path('../../../../data/tag.json', __FILE__))
  end

  let(:tag) do
    MultiJson.load(tag_file)
  end

  let(:attributes) { tag }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #tag" do
      expect(subject.tag).to eq('business')
    end

    it "returns the #created_at" do
      expected = DateTime.parse(attributes['created_at'])
      expect(subject.created_at).to eq(expected)
    end
  end
end