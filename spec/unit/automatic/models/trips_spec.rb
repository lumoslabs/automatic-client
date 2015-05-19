require 'spec_helper'

describe Automatic::Models::Trips do
  let(:trip_file) do
    File.read(File.expand_path('../../../../data/models/trip.json', __FILE__))
  end

  let(:trip) do
    MultiJson.load(trip_file)
  end

  let(:collection) do
    [trip]
  end

  subject { described_class.new(collection) }


  context "with no records" do
    let(:collection) { [] }

    context "statistic helper methods" do
      it "returns the #total_miles" do
        expect(subject.total_miles).to eq(0)
      end

      it "returns the #total_fuel_cost" do
        expect(subject.total_fuel_cost).to eq(0)
      end

      it "returns the #total_fuel_gallons" do
        expect(subject.total_fuel_gallons).to eq(0)
      end

      it "returns the #total_mpg" do
        expect(subject.total_mpg).to eq(0)
      end

      it "returns the #total_hard_brakes" do
        expect(subject.total_hard_brakes).to eq(0)
      end

      it "returns the #total_hard_accels" do
        expect(subject.total_hard_accels).to eq(0)
      end

      it "returns the #total_idling_time" do
        expect(subject.total_idling_time).to eq(0)
      end

      it "returns the #average_idling_time" do
        expect(subject.average_idling_time).to eq(0)
      end

      it "returns the #total_driving_time" do
        expect(subject.total_driving_time).to eq(0)
      end

      it "returns the #average_driving_time" do
        expect(subject.average_driving_time).to eq(0)
      end

      it "returns the #total_duration_over_70" do
        expect(subject.total_duration_over_70).to eq(0)
      end

      it "returns the #total_duration" do
        expect(subject.total_duration).to eq(0)
      end
    end

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be(false)
    end
  end

  context "with a single record" do
    context "statistic helper methods" do
      it "returns the #total_miles" do
        expect(subject.total_miles).to eq(4.0842715830000005)
      end

      it "returns the #total_fuel_cost" do
        expect(subject.total_fuel_cost).to eq(1.0428111627932486)
      end

      it "returns the #total_fuel_gallons" do
        expect(subject.total_fuel_gallons).to eq(0.06514105237583781)
      end

      it "returns the #total_mpg" do
        expect(subject.total_mpg).to eq(62.69888855088474)
      end

      it "returns the #total_hard_brakes" do
        expect(subject.total_hard_brakes).to eq(1)
      end

      it "returns the #total_hard_accels" do
        expect(subject.total_hard_accels).to eq(0)
      end

      it "returns the #total_idling_time" do
        expect(subject.total_idling_time).to eq(430)
      end

      it "returns the #average_idling_time" do
        expect(subject.average_idling_time).to eq(25.380710659898476)
      end

      it "returns the #total_driving_time" do
        expect(subject.total_driving_time).to eq(1264.2)
      end

      it "returns the #average_driving_time" do
        expect(subject.average_driving_time).to eq(74.61928934010153)
      end

      it "returns the #total_duration_over_70" do
        expect(subject.total_duration_over_70).to eq(3)
      end

      it "returns the #total_duration" do
        expect(subject.total_duration).to eq(1694.2)
      end
    end

    it "returns 1 for the #count" do
      expect(subject.count).to eq(1)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be(true)
    end
  end

  context "with 10 records" do
    let(:collection) { (1..10).map { trip } }

    context "statistic helper methods" do
      it "returns the #total_miles" do
        expect(subject.total_miles).to eq(40.84271583000001)
      end

      it "returns the #total_fuel_cost" do
        expect(subject.total_fuel_cost).to eq(10.428111627932488)
      end

      it "returns the #total_fuel_gallons" do
        expect(subject.total_fuel_gallons).to eq(0.6514105237583779)
      end

      it "returns the #total_mpg" do
        expect(subject.total_mpg).to eq(62.69888855088477)
      end

      it "returns the #total_hard_brakes" do
        expect(subject.total_hard_brakes).to eq(10)
      end

      it "returns the #total_hard_accels" do
        expect(subject.total_hard_accels).to eq(0)
      end

      it "returns the #total_idling_time" do
        expect(subject.total_idling_time).to eq(4300)
      end

      it "returns the #average_idling_time" do
        expect(subject.average_idling_time).to eq(25.38071065989847)
      end

      it "returns the #total_driving_time" do
        expect(subject.total_driving_time).to eq(12642.000000000004)
      end

      it "returns the #average_driving_time" do
        expect(subject.average_driving_time).to eq(74.61928934010153)
      end

      it "returns the #total_duration_over_70" do
        expect(subject.total_duration_over_70).to eq(30)
      end

      it "returns the #total_duration" do
        expect(subject.total_duration).to eq(16942.000000000004)
      end
    end

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be(true)
    end
  end
end
