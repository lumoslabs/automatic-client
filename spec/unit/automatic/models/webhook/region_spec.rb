require 'spec_helper'

describe Automatic::Models::Webhook::Region do
  let(:region_file) do
    File.read(File.expand_path('../../../../../data/models/webhook/region.json', __FILE__))
  end

  let(:region) do
    MultiJson.load(region_file)
  end

  let(:attributes) { region }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #name" do
      expect(subject.name).to eq('random')
    end

    it "returns the #status" do
      expect(subject.status).to eq('exited')
    end

    it "returns the #lat" do
      expect(subject.lat).to eq(77)
    end

    it "returns the #lon" do
      expect(subject.lon).to eq(2)
    end

    it "returns the #radius_m" do
      expect(subject.radius_m).to eq(5.21)
    end
  end
end
