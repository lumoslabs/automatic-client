require 'spec_helper'

describe Automatic::Client::Location do
  let(:location_file) do
    File.read(File.expand_path('../../data/location.json', __FILE__))
  end

  let(:location) do
    MultiJson.load(location_file)
  end

  let(:attributes) { location }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #name" do
      expect(subject.name).to eq('Ashbury St, SF, CA')
    end

    it "returns true for #name?" do
      expect(subject.name?).to be_true
    end

    it "returns the #lat" do
      expect(subject.lat).to eq(37.7692903)
    end

    it "aliases #latitude to #lat" do
      expect(subject.latitude).to eq(37.7692903)
    end

    it "returns the #lon" do
      expect(subject.lon).to eq(-122.4465469)
    end

    it "aliases #longitude to #lon" do
      expect(subject.longitude).to eq(-122.4465469)
    end

    it "returns the #accuracy_m" do
      expect(subject.accuracy_m).to eq(5)
    end

    it "aliases #accuracy_in_meters to #accuracy_m" do
      expect(subject.accuracy_in_meters).to eq(5)
    end

    it "exposes a coordinates array" do
      expect(subject.coordinates).to eq([37.7692903, -122.4465469])
    end
  end

  context "comparing" do
    it "returns true if the location has exact lat/lon" do
      location1 = subject.dup
      location2 = subject.dup

      expect(location1).to eq(location2)
    end

    it "returns false if the longitude doesn't match" do
      location1 = described_class.new(attributes.dup.merge!('lon' => 123))
      location2 = described_class.new(attributes.dup.merge!('lon' => 789))

      expect(location1).to_not eq(location2)
    end

    it "returns false if the latitude doesn't match" do
      location1 = described_class.new(attributes.dup.merge!('lat' => 123))
      location2 = described_class.new(attributes.dup.merge!('lat' => 789))

      expect(location1).to_not eq(location2)
    end

    it "returns false if the latitude and longitude don't match" do
      location1 = described_class.new(attributes.dup.merge!('lon' => 123, 'lat' => 123))
      location2 = described_class.new(attributes.dup.merge!('lon' => 789, 'lat' => 789))

      expect(location1).to_not eq(location2)
    end
  end
end
