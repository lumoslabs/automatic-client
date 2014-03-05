require 'spec_helper'

describe Automatic::CoreExtension::Time do
  let(:time_in_milliseconds) { 1383448450201.to_s }

  describe "#from_milliseconds" do
    it "returns the unix timestamp from milliseconds" do
      expected = Time.parse("2013-11-02 23:14:10 -0400")
      expect(time_in_milliseconds.extend(described_class).from_milliseconds).to eq(expected)
    end
  end

  describe "#in_zone" do
    it "returns the time in specified timezone" do
      timestamp = Time.parse("2013-11-02 23:14:10 -0400")
      expected  = Time.parse("2013-11-02 15:14:10 -0400")
      expect(timestamp.extend(described_class).in_zone('America/Los_Angeles')).to eq(expected)
    end

    it "returns the time in UTC by default" do
      timestamp = Time.parse("2013-11-02 23:14:10 -0400")
      expected  = timestamp
      expect(timestamp.extend(described_class).in_zone).to eq(expected)
    end
  end
end
