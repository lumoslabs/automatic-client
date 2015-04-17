require 'spec_helper'

describe Automatic::Models::Response::Options do
  let(:options_file) do
    File.read(File.expand_path('../../../../../data/response/options.json', __FILE__))
  end

  let(:options) do
    MultiJson.load(options_file)
  end

  let(:attributes) { options }

  subject { described_class.new(attributes) }

  context "with all params" do
    it "returns the #name" do
      expect(subject.name).to eq('Trip')
    end

    it "returns the #description" do
      expect(subject.description).to eq('Trip API')
    end

    it "returns a MimeTypes collection for #renders" do
      expect(subject.renders).to be_a(Automatic::Models::Response::MimeTypes)
    end

    it "returns a MimeTypes collection for #parses" do
      expect(subject.parses).to be_a(Automatic::Models::Response::MimeTypes)
    end
  end
end
