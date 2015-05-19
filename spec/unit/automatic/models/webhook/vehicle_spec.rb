require 'spec_helper'

describe Automatic::Models::Webhook::Vehicle do
  let(:vehicle_file) do
    File.read(File.expand_path('../../../../../data/models/webhook/vehicle.json', __FILE__))
  end

  let(:vehicle) do
    MultiJson.load(vehicle_file)
  end

  let(:attributes) { vehicle }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #id" do
      expect(subject.id).to eq('C_345897349857')
    end

    it "returns the #year" do
      expect(subject.year).to eq(2009)
    end

    it "returns the #make" do
      expect(subject.make).to eq('Mazda')
    end

    it "returns the #model" do
      expect(subject.model).to eq('3')
    end

    it "returns the #color" do
      expect(subject.color).to eq('#596064')
    end

    it "returns the #display_name" do
      expect(subject.display_name).to eq('My Mazda 3')
    end
  end
end
