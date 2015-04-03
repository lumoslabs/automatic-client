require 'spec_helper'

describe Automatic::Models::Error do
  let(:attributes) do
    {
      'status'  => 404,
      'message' => 'Not Found'
    }
  end

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the error status code" do
      expect(subject.status).to eq(404)
    end

    it "returns the error message" do
      expect(subject.message).to eq('Not Found')
    end

    it "returns the #full_message" do
      expected = "Status Code: 404, Message: Not Found"
      expect(subject.full_message).to eq(expected)
    end
  end
end
