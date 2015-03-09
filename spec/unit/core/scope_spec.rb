require 'spec_helper'

describe Automatic::Core::Scope do
  let(:scope_file) do
    File.read(File.expand_path('../../../data/scope.json', __FILE__))
  end

  let(:scope) do
    MultiJson.load(scope_file)
  end

  subject { described_class.new(scope) }

  it "returns the #name" do
    expect(subject.name).to eq('scope:test')
  end

  it "returns the #description" do
    expect(subject.description).to eq('Test Scope')
  end

  it "returns #extra" do
    expect(subject.extra).to eq('Extra description')
  end
end
