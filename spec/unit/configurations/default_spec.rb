require 'spec_helper'

describe Automatic::Configurations::Default do
  context "with ENV vars" do
    before(:each) do
      stub_const('Automatic::Configurations::Default::USER_AGENT', 'Automatic Ruby Gem 1.2.3')

      Automatic::Configuration.stub(:keys).and_return([:access_token])

      ENV.stub(:[]).with('AUTOMATIC_ACCESS_TOKEN').and_return('abcd123')
      ENV.stub(:[]).with('AUTOMATIC_API_HOST').and_return('http://api.example.com')
      ENV.stub(:[]).with('AUTOMATIC_MEDIA_TYPE').and_return('text/csv')
      ENV.stub(:[]).with('AUTOMATIC_CONTENT_TYPE').and_return('text/csv')
      ENV.stub(:[]).with('AUTOMATIC_AUTO_PAGINATE').and_return('false')
      ENV.stub(:[]).with('AUTOMATIC_REQUEST_LOGGER').and_return(Logger.new(STDOUT))
      ENV.stub(:[]).with('AUTOMATIC_CACHE_LOGGER').and_return(Logger.new(STDOUT))
      ENV.stub(:[]).with('AUTOMATIC_USER_AGENT').and_return('TestAgent')
    end

    it "returns abcd123 for the #access_token" do
      expect(described_class.access_token).to eq('abcd123')
    end

    it "returns TestAgent for the #user_agent" do
      expect(described_class.user_agent).to eq('TestAgent')
    end

    it "returns http://api.example.com for the #api_host" do
      expect(described_class.api_host).to eq('http://api.example.com')
    end

    it "returns text/csv for the default #media_type" do
      expect(described_class.media_type).to eq('text/csv')
    end

    it "returns text/csv for the default #content_type" do
      expect(described_class.content_type).to eq('text/csv')
    end

    it "returns false for #auto_paginate" do
      expect(described_class.auto_paginate).to be_false
    end

    it "returns a logger for the #request_logger" do
      expect(described_class.request_logger).to be_a(Logger)
    end

    it "returns a logger for the #cache_logger" do
      expect(described_class.cache_logger).to be_a(Logger)
    end

    it "returns the #options for specified Automatic::Configuration.keys" do
      expected = {
        :access_token => 'abcd123'
      }
      expect(described_class.options).to eq(expected)
    end

    it "returns the default #connection_options hash" do
      expected = {
        :headers => {
          :accept       => 'text/csv',
          :user_agent   => 'TestAgent',
          :content_type => 'text/csv'
        }
      }
      expect(described_class.connection_options).to eq(expected)
    end
  end

  context "without ENV vars" do
    before(:each) do
      stub_const('Automatic::Configurations::Default::USER_AGENT', 'Automatic Ruby Gem 1.2.3')

      Automatic::Configuration.stub(:keys).and_return([:access_token])

      ENV.stub(:[]).with('AUTOMATIC_ACCESS_TOKEN').and_return(nil)
      ENV.stub(:[]).with('AUTOMATIC_API_HOST').and_return(nil)
      ENV.stub(:[]).with('AUTOMATIC_MEDIA_TYPE').and_return(nil)
      ENV.stub(:[]).with('AUTOMATIC_CONTENT_TYPE').and_return(nil)
      ENV.stub(:[]).with('AUTOMATIC_AUTO_PAGINATE').and_return(nil)
      ENV.stub(:[]).with('AUTOMATIC_REQUEST_LOGGER').and_return(nil)
      ENV.stub(:[]).with('AUTOMATIC_CACHE_LOGGER').and_return(nil)
      ENV.stub(:[]).with('AUTOMATIC_USER_AGENT').and_return(nil)
    end

    it "returns nil for the #access_token" do
      expect(described_class.access_token).to be_nil
    end

    it "returns a default #user_agent based on the VERSION" do
      expect(described_class.user_agent).to eq('Automatic Ruby Gem 1.2.3')
    end

    it "returns https://api.automatic.com for the #api_host" do
      expect(described_class.api_host).to eq('https://api.automatic.com')
    end

    it "returns application/json for the default #media_type" do
      expect(described_class.media_type).to eq('application/json')
    end

    it "returns application/json for the default #content_type" do
      expect(described_class.content_type).to eq('application/json')
    end

    it "returns false for #auto_paginate" do
      expect(described_class.auto_paginate).to be_false
    end

    it "returns nil for the #request_logger" do
      expect(described_class.request_logger).to be_a(Logger)
    end

    it "returns nil for the #cache_logger" do
      expect(described_class.cache_logger).to be_a(Logger)
    end

    it "returns the #options for specified Automatic::Configuration.keys" do
      expected = {
        :access_token => nil
      }
      expect(described_class.options).to eq(expected)
    end

    it "returns the default #connection_options hash" do
      expected = {
        :headers => {
          :accept       => 'application/json',
          :user_agent   => 'Automatic Ruby Gem 1.2.3',
          :content_type => 'application/json'
        }
      }
      expect(described_class.connection_options).to eq(expected)
    end
  end
end
