require 'spec_helper'

describe Automatic::Models::Users do
  let(:user_file) do
    File.read(File.expand_path('../../../../data/user.json', __FILE__))
  end

  let(:user) do
    MultiJson.load(user_file)
  end

  let(:collection) { [user] }

  subject { described_class.new(collection) }

  context "with no records" do
    let(:collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_false
    end
  end

  context "with a single record" do
    it "returns 1 for the #count" do
      expect(subject.count).to eq(1)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end

  context "with 10 records" do
    let(:collection) { (1..10).map { user } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end
end
