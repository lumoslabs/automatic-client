require 'spec_helper'

describe Automatic::Client::Request do
  subject { described_class }

  describe ".access_token" do
    it "returns the specified access token" do
      ENV.stub(:fetch).and_return(123)
      expect(subject.access_token).to eq(123)
    end

    it "raises a MissingAccessTokenError if not provided" do
      ENV.stub(:fetch).and_return do
        raise KeyError
      end

      lambda { subject.access_token }.should raise_error(Automatic::Client::Request::MissingAccessTokenError)
    end
  end

  describe ".api_host" do
    it "returns the specified api host" do
      ENV.stub(:fetch).and_return('http://example.com')
      expect(subject.api_host).to eq('http://example.com')
    end

    it "raises a MissingApiHostError if not provided" do
      ENV.stub(:fetch).and_return do
        raise KeyError
      end

      lambda { subject.api_host }.should raise_error(Automatic::Client::Request::MissingApiHostError)
    end
  end
end
