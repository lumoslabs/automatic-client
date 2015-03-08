require 'spec_helper'

describe Automatic::Client::Trip do
  let(:trip_file) do
    File.read(File.expand_path('../../data/trip.json', __FILE__))
  end

  let(:trip) do
    MultiJson.load(trip_file)
  end

  let(:attributes) { trip }

  subject { described_class.new(attributes) }

  context "with all values" do
    context "associations" do
      it "returns a Location object for #start_location" do
        expect(subject.start_location).to be_a(Automatic::Client::Location)
      end

      it "returns a Location object for #end_location" do
        expect(subject.end_location).to be_a(Automatic::Client::Location)
      end

      it "returns an Address object for #start_address" do
        expect(subject.start_address).to be_a(Automatic::Client::Address)
      end

      it "returns an Address object for #end_address" do
        expect(subject.start_address).to be_a(Automatic::Client::Address)
      end

      it "returns a Polyline object for #polyline" do
        expect(subject.polyline).to be_a(Automatic::Client::Polyline)
      end
    end

    it "returns the #id" do
      expect(subject.id).to eq('T_524da549e4b08d1af17f6dca')
    end

    it "returns the URL for the #vehicle" do
      expect(subject.vehicle).to eq("https://api.automatic.com/vehicle/C_3243445654645/")
    end

    it "returns the URL for the #user" do
      expect(subject.user).to eq("https://api.automatic.com/user/U_346534245654/")
    end

    it "returns the #url" do
      expect(subject.url).to eq('https://api.automatic.com/trip/T_524da549e4b08d1af17f6dca/')
    end

    it "returns the #score" do
      expect(subject.score).to eq(44)
    end

    it "returns the #end_at" do
      expected = Time.parse('2015-03-08 06:22:40 UTC')
      expect(subject.end_at.to_s).to eq(expected.to_s)
    end

    it "returns the #end_time_zone" do
      expect(subject.end_time_zone).to eq('America/Los_Angeles')
    end

    it "returns the #start_at" do
      expected = Time.parse('2015-03-08 05:54:25 UTC')
      expect(subject.start_at.to_s).to eq(expected.to_s)
    end

    it "returns the #start_time_zone" do
      expect(subject.start_time_zone).to eq('America/Los_Angeles')
    end

    it "returns the #duration" do
      expect(subject.duration).to eq(1694.2)
    end

    it "returns the #path encoded polyline" do
      expected = "{xoeFlkjjVmOhBsA_ToEir@gDch@sAgSi@cIi@qI~IgAn@w@DEKMMOCOAEeAyAcDqEwEmG]c@g@YuCyD@I@IpAiBlAaBpAkBcHuJeGiIgFeHgTyYWa@DG"
      expect(subject.path).to eq(expected)
    end

    it "returns the #distance_in_meters" do
      expect(subject.distance_in_meters).to eq(6573.416666666661)
    end

    it "returns the #distance_in_miles" do
      expect(subject.distance_in_miles).to eq(4.0842715830000005)
    end

    it "returns the #fuel_cost" do
      expect(subject.fuel_cost).to eq(1.0428111627932486)
    end

    it "returns the #fuel_volume_l" do
      expect(subject.fuel_volume_l).to eq(0.2465857561582522)
    end

    it "returns the #fuel_volume" do
      expect(subject.fuel_volume).to eq(0.06514105237583781)
    end

    it "returns the #average_kmpl" do
      expect(subject.average_kmpl).to eq(16.56434586845349)
    end

    it "returns the #average_mpg" do
      expect(subject.average_mpg).to eq(39.0)
    end

    describe ".events" do
      context "with events" do
      end

      context "without events" do
        it "returns an empty collection" do
          expect(subject.events).to eq([])
        end

        it "returns false for #events?" do
          expect(subject.events?).to be_false
        end
      end
    end

    context "event counter cache" do
      it "returns the number of #hard_accels" do
        expect(subject.hard_accels).to eq(0)
      end

      it "returns the number of #hard_brakes" do
        expect(subject.hard_brakes).to eq(1)
      end

      it "returns the #duration_over_80 in seconds" do
        expect(subject.duration_over_80).to eq(0)
      end

      it "returns the #duration_over_75 in seconds" do
        expect(subject.duration_over_75).to eq(2)
      end

      it "returns the #duration_over_70 in seconds" do
        expect(subject.duration_over_70).to eq(3)
      end
    end
  end
end
