require 'spec_helper'

describe Automatic::Models::Webhook::Location do
  let(:location_file) do
    File.read(File.expand_path('../../../../../data/models/webhook/location.json', __FILE__))
  end

  let(:location) do
    MultiJson.load(location_file)
  end

  let(:attributes) { location }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #name" do
      expect(subject.name).to eq('102 Street Drive, San Francisco, CA 94118, USA')
    end

    it "returns the #display_name" do
      expect(subject.display_name).to eq('Street Dr, San Francisco, CA')
    end

    it "returns the #lat" do
      expect(subject.lat).to eq(40.35345)
    end

    it "returns the #lon" do
      expect(subject.lon).to eq(-41.23234)
    end

    it "returns the #accuracy_m" do
      expect(subject.accuracy_m).to eq(10)
    end
  end
end
