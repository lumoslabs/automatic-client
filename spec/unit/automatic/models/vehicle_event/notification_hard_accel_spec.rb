require 'spec_helper'

describe Automatic::Models::VehicleEvent::NotificationHardAccel do
  let(:event_file) do
    File.read(File.expand_path('../../../../../data/vehicle_event/notification_hard_accel.json', __FILE__))
  end

  let(:event) do
    MultiJson.load(event_file)
  end

  let(:attributes) { event }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #lat" do
      expect(subject.lat).to eq(10.55)
    end

    it "returns the #lon" do
      expect(subject.lon).to eq(-91.5)
    end

    it "returns the #type" do
      expect(subject.type).to eq('hard_accel')
    end

    it "returns the #g_force" do
      expect(subject.g_force).to eq(0.3)
    end

    it "returns the #created_at stamp" do
      expected = DateTime.parse(attributes['created_at'])
      expect(subject.created_at).to eq(expected)
    end
  end
end
