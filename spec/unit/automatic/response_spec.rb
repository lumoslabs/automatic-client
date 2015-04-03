require 'spec_helper'

describe Automatic::Response do
  let(:faraday_response) { Faraday::Response.new }

  subject { described_class.new(faraday_response) }

  context "constants" do
    it "returns a STATUS_MAP" do
      expect(described_class::STATUS_MAP.keys).to eq([:failure, :redirect, :success, :server_error])
    end
  end

  it "returns the delegated object" do
    expect(subject.__getobj__.class).to eq(Faraday::Response)
  end

  context ".on block to execute with the response" do
    context "on success" do
      before(:each) do
        faraday_response.stub(:status).and_return(200)
      end

      it "returns the block on 200 status code" do
        val = ''

        subject.on(200) do |resp|
          val += 'success'
        end

        expect(val).to eq('success')
      end

      it "does not return a non successful status" do
        val = ''

        subject.on(404) do |resp|
          val += 'error'
        end

        expect(val).to eq('')
      end
    end

    context "on failure" do
    end
  end

  context "HTTP ALLOW" do
    context "with ALLOW header" do
      before(:each) do
        faraday_response.stub(:headers).and_return({ 'allow' => 'GET,PUT' })
      end

      it "returns the value of the ALLOW header" do
        expect(subject.allow_header).to eq('GET,PUT')
      end

      it "returns a collection of #allowed_methods" do
        expect(subject.allowed_methods).to eq(['GET', 'PUT'])
      end

      it "returns true when checking if GET is #allowed?" do
        expect(subject.allowed?('GET')).to be(true)
      end

      it "returns false when checking if POST is #allowed?" do
        expect(subject.allowed?('POST')).to be(false)
      end
    end

    context "without ALLOW header" do
      before(:each) do
        faraday_response.stub(:headers).and_return({})
      end

      it "returns an empty string if there is no ALLOW header" do
        expect(subject.allow_header).to eq('')
      end

      it "returns an empty collection for #allowed_methods" do
        expect(subject.allowed_methods).to be_empty
      end

      it "returns false when checking if a method is #allowed?" do
        expect(subject.allowed?('PUT')).to be(false)
      end
    end
  end
end

