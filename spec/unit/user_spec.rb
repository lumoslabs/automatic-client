require 'spec_helper'

describe Automatic::Client::User do
  let(:user_file) do
    File.read(File.expand_path('../../data/user.json', __FILE__))
  end

  let(:user) do
    MultiJson.load(user_file)
  end

  let(:attributes) { user }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #id" do
      expect(subject.id).to eq('6sQPMSEW71FQ3H')
    end
  end
end
