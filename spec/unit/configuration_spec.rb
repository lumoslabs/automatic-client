require 'spec_helper'

describe Automatic::Configuration do
  let(:available_keys) do
    [
      :api_host,
      :access_token,
      :connection_options,
      :middleware,
      :user_agent,
      :content_type,
      :media_type,
      :auto_paginate,
      :cache_logger,
      :request_logger
    ]
  end

  subject { described_class.new }

  it "returns the default set of available configuration #keys" do
    expect(described_class.keys).to eq(available_keys)
  end

  context "available methods" do
    it "responds to #api_host" do
      expect(subject).to respond_to(:api_host)
    end

    it "responds to #access_token" do
      expect(subject).to respond_to(:access_token)
    end

    it "responds to #connection_options" do
      expect(subject).to respond_to(:connection_options)
    end

    it "responds to #middleware" do
      expect(subject).to respond_to(:middleware)
    end

    it "responds to #user_agent" do
      expect(subject).to respond_to(:user_agent)
    end

    it "responds to #media_type" do
      expect(subject).to respond_to(:media_type)
    end

    it "responds to #content_type" do
      expect(subject).to respond_to(:content_type)
    end

    it "responds to #auto_paginate" do
      expect(subject).to respond_to(:auto_paginate)
    end

    it "responds to #cache_logger" do
      expect(subject).to respond_to(:cache_logger)
    end

    it "responds to #cache_logger?" do
      expect(subject).to respond_to(:cache_logger?)
    end

    it "responds to #request_logger" do
      expect(subject).to respond_to(:request_logger)
    end

    it "responds to #request_logger?" do
      expect(subject).to respond_to(:request_logger?)
    end
  end

  context "#reset!" do
    it "resets values back to default" do
      Automatic::Configurations::Default.stub(:options).and_return(access_token: 'abcd1234')

      config = described_class.new(access_token: 'user')

      expect(config.access_token).to eq('user')

      config.reset!

      expect(config.access_token).to eq('abcd1234')
    end
  end

  context "initialization" do
    context "with no defaults" do
      before(:each) do
        Automatic::Configurations::Default.stub(:options).and_return({})
      end

      it "returns nil for the #access_token" do
        expect(subject.access_token).to be_nil
      end
    end

    context "with defaults" do
      before(:each) do
        Automatic::Configurations::Default.stub(:options).and_return(access_token: 'abcd1234')
      end

      it "returns 'abcd1234' for the #access_token" do
        expect(subject.access_token).to eq('abcd1234')
      end
    end

    context "with attributes provided" do
      it "returns 'initialized' for the #access_token" do
        config = described_class.new(access_token: 'initialized')
        expect(config.access_token).to eq('initialized')
      end
    end
  end

  context ".configure" do
    it "returns 'blocked' for the #access_token" do
      subject.configure do |f|
        f.access_token = 'blocked'
      end

      expect(subject.access_token).to eq('blocked')
    end
  end
end
