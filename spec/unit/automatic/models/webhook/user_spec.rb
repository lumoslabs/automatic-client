require 'spec_helper'

describe Automatic::Models::Webhook::User do
  let(:user_file) do
    File.read(File.expand_path('../../../../../data/models/webhook/user.json', __FILE__))
  end

  let(:user) do
    MultiJson.load(user_file)
  end

  let(:attributes) { user }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #id" do
      expect(subject.id).to eq('93858345739847543')
    end

    it "returns the #v2_id" do
      expect(subject.v2_id).to eq('U_9308534905834905')
    end
  end
end
