require 'spec_helper'

describe Automatic::Models::Tagging do
  let(:tagging_file) do
    File.read(File.expand_path('../../../../data/tagging.json', __FILE__))
  end

  let(:tagging) do
    MultiJson.load(tagging_file)
  end

  let(:attributes) { tagging }

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
