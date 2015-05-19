require 'spec_helper'

describe Automatic::Models::Webhook::Trip do
  let(:trip_file) do
    File.read(File.expand_path('../../../../../data/models/webhook/trip.json', __FILE__))
  end

  let(:trip) do
    MultiJson.load(trip_file)
  end

  let(:attributes) { trip }

  subject { described_class.new(attributes) }

  context "with all values" do
    context "associations" do
      it "returns a Polyline object for #polyline" do
        expect(subject.polyline).to be_a(Automatic::Models::Polyline)
      end

      it "returns a Location object for #start_location" do
        expect(subject.start_location).to be_a(Automatic::Models::Webhook::Location)
      end

      it "returns a Location object for #end_location" do
        expect(subject.end_location).to be_a(Automatic::Models::Webhook::Location)
      end
    end

    it "returns the #id" do
      expect(subject.id).to eq('T_234325345')
    end

    it "returns the #path" do
      expect(subject.path).to eq('1234')
    end

    it "returns the #distance_m" do
      expect(subject.distance_m).to eq(16566.02734375)
    end

    it "returns the #distance_in_miles" do
      expect(subject.distance_in_miles).to eq(10.293631986)
    end

    it "returns the #hard_accels" do
      expect(subject.hard_accels).to eq(0)
    end

    it "returns the #hard_brakes" do
      expect(subject.hard_brakes).to eq(0)
    end

    it "returns the #start_time_zone" do
      expect(subject.start_time_zone).to eq('America/New_York')
    end

    it "returns the #duration_over_80 in seconds" do
      expect(subject.duration_over_80).to eq(8)
    end

    it "returns the #duration_over_75 in seconds" do
      expect(subject.duration_over_75).to eq(7)
    end

    it "returns the #duration_over_70 in seconds" do
      expect(subject.duration_over_70).to eq(6)
    end

    it "returns the #fuel_cost" do
      expect(subject.fuel_cost).to eq(0.9769523739814758)
    end

    it "returns the #fuel_volume" do
      expect(subject.fuel_volume).to eq(0.3369963467121124)
    end

    it "returns the #average_mpg" do
      expect(subject.average_mpg).to eq(30.5452938079834)
    end

    it "returns the unix #start_time in milliseconds" do
      expect(subject.start_time).to eq(1430396616435)
    end

    it "returns the #start_at time" do
      expected = '2015-04-30 08:23:36 -0400'
      expect(subject.start_at.to_s).to eq(expected)
    end
  end
end
