require 'spec_helper'

describe Automatic::Models::Vehicle do
  let(:vehicle_file) do
    File.read(File.expand_path('../../../../data/vehicle.json', __FILE__))
  end

  let(:vehicle) do
    MultiJson.load(vehicle_file)
  end

  let(:attributes) { vehicle }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #id" do
      expect(subject.id).to eq('529e5772e4b00a2ddb562f1f')
    end

    it "returns the #url" do
      expect(subject.url).to eq('https://api.automatic.com/v1/vehicles/529e5772e4b00a2ddb562f1f')
    end

    it "returns the #year" do
      expect(subject.year).to eq(2001)
    end

    it "returns the #make" do
      expect(subject.make).to eq('Acura')
    end

    it "returns the #model" do
      expect(subject.model).to eq('MDX')
    end

    it "returns the #sub_model" do
      expect(subject.sub_model).to eq('Sub')
    end

    # NOTE: This should return the HEX
    it "returns the #color" do
      expect(subject.color).to eq('purple')
    end

    it "returns the #display_name" do
      expect(subject.display_name).to eq('My Speed Demon')
    end
  end
end
