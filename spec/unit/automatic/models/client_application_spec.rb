require 'spec_helper'

describe Automatic::Models::ClientApplication do
  let(:client_application_file) do
    File.read(File.expand_path('../../../../data/models/client_application.json', __FILE__))
  end

  let(:client_application) do
    MultiJson.load(client_application_file)
  end

  let(:attributes) { client_application }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #id" do
      expect(subject.id).to eq('23434534534545')
    end
  end
end
