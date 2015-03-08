require 'spec_helper'

describe Automatic::Client::Address do
  let(:address_file) do
    File.read(File.expand_path('../../data/address.json', __FILE__))
  end

  let(:address) do
    MultiJson.load(address_file)
  end

  let(:attributes) { address }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #name" do
      expect(subject.name).to eq('1234 South Street')
    end

    it "returns the #display_name" do
      expect(subject.display_name).to eq('1234 South Street, Somewhere, CA')
    end

    it "returns the #street_number" do
      expect(subject.street_number).to eq('1234')
    end

    it "returns the #street_name" do
      expect(subject.street_name).to eq('South Street')
    end

    it "returns the #state" do
      expect(subject.state).to eq('CA')
    end

    it "returns the #city" do
      expect(subject.city).to eq('Somewhere')
    end

    it "returns the #country" do
      expect(subject.country).to eq('US')
    end
  end
end
