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
      expect(subject.id).to eq('U_6sQPMSEW71FQ3H')
    end

    it "returns the #url" do
      expect(subject.url).to eq('https://api.automatic.com/user/U_6sQPMSEW71FQ3H/')
    end

    it "returns the #username" do
      expect(subject.username).to eq('lester@example.com')
    end

    it "returns the #first_name" do
      expect(subject.first_name).to eq('Lester')
    end

    it "returns the #last_name" do
      expect(subject.last_name).to eq('Tester')
    end

    it "returns the #full_name" do
      expect(subject.full_name).to eq('Lester Tester')
    end

    it "returns the #email" do
      expect(subject.email).to eq('lester@example.com')
    end
  end
end
