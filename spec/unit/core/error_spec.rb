require 'spec_helper'

describe Automatic::Core::Error do
  let(:error_file) do
    File.read(File.expand_path('../../../data/core/error.json', __FILE__))
  end

  let(:error) do
    MultiJson.load(error_file)
  end

  subject { described_class.new(error) }

  it "returns the #code" do
    expect(subject.code).to eq(404)
  end

  it "returns the #name" do
    expect(subject.name).to eq('not_found')
  end

  it "returns #extra" do
    expect(subject.description).to eq('Record not Found')
  end
end
