require 'spec_helper'

describe Automatic::Models::Vehicles do
  let(:vehicle_file) do
    File.read(File.expand_path('../../../../data/models/vehicle.json', __FILE__))
  end

  let(:vehicle) do
    MultiJson.load(vehicle_file)
  end

  let(:collection) { [vehicle] }

  before { allow_any_instance_of(described_class).to receive(:collect_all) { collection }  }

  subject { described_class.new }

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
    let(:collection) { (1..10).map { vehicle } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be(true)
    end
  end
end
