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
    it "returns the #id" do
      expect(subject.id).to eq('524da549e4b08d1af17f6dca')
    end

    it "returns the #uri" do
      expect(subject.uri).to eq('https://api.automatic.com/v1/trips/524da549e4b08d1af17f6dca')
    end

    it "returns the #end_time in milliseconds" do
      expect(subject.end_time).to eq(1383449950201)
    end

    it "returns the #end_at" do
      expected = Time.parse("2013-11-02 15:39:10 -0400")
      expect(subject.end_at).to eq(expected)
    end

    it "returns the #end_time_zone" do
      expect(subject.end_time_zone).to eq('America/Los_Angeles')
    end

    it "returns the #start_time in milliseconds" do
      expect(subject.start_time).to eq(1383448450201)
    end

    it "returns the #start_at" do
      expected = Time.parse("2013-11-02 15:14:10 -0400")
      expect(subject.start_at).to eq(expected)
    end

    it "returns the #start_time_zone" do
      expect(subject.start_time_zone).to eq('America/Los_Angeles')
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

    it "returns the #fuel_volume" do
      expect(subject.fuel_volume).to eq(0.2465857561582522)
    end

    it "returns the #average_mpg" do
      expect(subject.average_mpg).to eq(16.56434586845349)
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
