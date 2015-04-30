require 'spec_helper'

describe Automatic::Models::Device do
  let(:device_file) do
    File.read(File.expand_path('../../../../data/models/device.json', __FILE__))
  end

  let(:device) do
    MultiJson.load(device_file)
  end

  let(:attributes) { device }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #id" do
      expect(subject.id).to eq('98345345345')
    end

    it "returns the #url" do
      expect(subject.url).to eq('https://api.automatic.com/device/98345345345/')
    end

    it "returns the #version" do
      expect(subject.version).to eq(1)
    end
  end
end
