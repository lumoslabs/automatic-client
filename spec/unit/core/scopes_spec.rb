require 'spec_helper'

describe Automatic::Core::Scopes do
  let(:scope_file) do
    File.read(File.expand_path('../../../data/scope.json', __FILE__))
  end

  let(:scope) do
    MultiJson.load(scope_file)
  end

  let(:collection) { [scope] }

  subject { described_class.new(collection) }

  describe ".find_by_scope" do
    context "when record is found" do
      it "returns the scope:test record" do
        expect(subject.find_by_scope('scope:test')).to_not be_nil
      end
    end

    context "when record is not found" do
      it "returns nil" do
        expect(subject.find_by_scope('not:found')).to be_nil
      end
    end
  end

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
    let(:collection) { (1..10).map { scope } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end
end
