require 'spec_helper'

describe Automatic::Core::Webhook do
  let(:webhook_file) do
    File.read(File.expand_path('../../../data/core/webhook.json', __FILE__))
  end

  let(:webhook) do
    MultiJson.load(webhook_file)
  end

  subject { described_class.new(webhook) }

  it "returns the #name" do
    expect(subject.name).to eq('trip:finished')
  end

  it "returns the #type" do
    expect(subject.type).to eq('finished')
  end

  it "returns the #description" do
    expect(subject.description).to eq('Sent after a trip is completed and processed by Automatic.')
  end
end
