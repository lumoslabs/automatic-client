require 'spec_helper'

describe Automatic::Models::Response::MimeType do
  let(:mime_type_file) do
    File.read(File.expand_path('../../../../../data/models/response/mime_type.json', __FILE__))
  end

  let(:mime_type) do
    MultiJson.load(mime_type_file)
  end

  let(:attributes) { mime_type }

  subject { described_class.new(attributes) }

  context "with all params" do
    it "returns the #name" do
      expect(subject.name).to eq('application/json')
    end
  end
end
