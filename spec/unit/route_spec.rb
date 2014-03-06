require 'spec_helper'

describe Automatic::Route do
  let(:name) { 'trips' }
  let(:path) { 'https://api.example.com/v1/trips' }
  let(:options) { {} }

  subject { described_class.new(name, path, options) }

  context "with defaults" do
    it "returns the #name" do
      expect(subject.name).to eq('trips')
    end

    it "returns the #url_for" do
      expect(subject.url_for).to eq('https://api.example.com/v1/trips')
    end
  end

  context "with options" do
    context "with templated URI" do
      let(:path) { 'https://api.example.com/v1/trip/{id}' }
      let(:options) { { templated: true } }

      it "returns the #url_for" do
        expect(subject.url_for(id: '123')).to eq('https://api.example.com/v1/trip/123')
      end
    end
  end
end
