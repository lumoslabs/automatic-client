require 'spec_helper'

describe Automatic::Core::Webhooks do
  let(:webhook_file) do
    File.read(File.expand_path('../../../data/webhook.json', __FILE__))
  end

  let(:webhook) do
    MultiJson.load(webhook_file)
  end

  let(:collection) { [webhook] }

  subject { described_class.new(collection) }

  describe ".find_by_type" do
    context "when record is found" do
      it "returns the trip:finished record" do
        expect(subject.find_by_name('trip:finished')).to_not be_nil
      end
    end

    context "when record is not found" do
      it "returns nil" do
        expect(subject.find_by_name('not:found')).to be_nil
      end
    end
  end

  context "with no records" do
    let(:collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be(false)
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
    let(:collection) { (1..10).map { webhook } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end
end
