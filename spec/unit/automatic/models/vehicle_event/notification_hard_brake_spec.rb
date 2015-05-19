require 'spec_helper'

describe Automatic::Models::VehicleEvent::NotificationHardBrake do
  let(:event_file) do
    File.read(File.expand_path('../../../../../data/models/vehicle_event/notification_hard_brake.json', __FILE__))
  end

  let(:event) do
    MultiJson.load(event_file)
  end

  let(:attributes) { event }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #lat" do
      expect(subject.lat).to eq(20.52)
    end

    it "returns the #lon" do
      expect(subject.lon).to eq(-51.58)
    end

    it "returns the #type" do
      expect(subject.type).to eq('hard_brake')
    end

    it "returns the #g_force" do
      expect(subject.g_force).to eq(0.4)
    end

    it "returns the #created_at stamp" do
      expected = DateTime.parse(attributes['created_at'])
      expect(subject.created_at).to eq(expected)
    end
  end
end
