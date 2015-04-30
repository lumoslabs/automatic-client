require 'spec_helper'

describe Automatic::Models::VehicleEvent::NotificationSpeeding do
  let(:event_file) do
    File.read(File.expand_path('../../../../../data/models/vehicle_event/notification_speeding.json', __FILE__))
  end

  let(:event) do
    MultiJson.load(event_file)
  end

  let(:attributes) { event }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #start_distance in meters" do
      expect(subject.start_distance_m).to eq(10506.0)
    end

    it "returns the #end_distance in meters" do
      expect(subject.end_distance_m).to eq(10569.0)
    end

    it "returns the #total_distance in meters" do
      expect(subject.total_distance_m).to eq(63.0)
    end

    it "returns the #type" do
      expect(subject.type).to eq('speeding')
    end

    it "returns the #velocity kilometers per hour" do
      expect(subject.velocity_kph).to eq(112.65)
    end

    it "returns the #velocity in miles per hour" do
      expect(subject.velocity_mph).to eq(69.99744315000001)
    end

    it "returns the #started_at stamp" do
      expected = DateTime.parse(attributes['started_at'])
      expect(subject.started_at).to eq(expected)
    end

    it "returns the #ended_at stamp" do
      expected = DateTime.parse(attributes['ended_at'])
      expect(subject.ended_at).to eq(expected)
    end

    it "returns the #duration in seconds of the event" do
      expect(subject.duration).to eq(2.0)
    end
  end
end
