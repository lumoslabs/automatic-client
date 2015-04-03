require 'spec_helper'

describe Automatic::Core::Errors do
  let(:error_file) do
    File.read(File.expand_path('../../../data/error.json', __FILE__))
  end

  let(:error) do
    MultiJson.load(error_file)
  end

  let(:collection) { [error] }

  subject { described_class.new(collection) }

  describe ".find_by_code" do
    context "when record is found" do
      it "returns the 404 record" do
        expect(subject.find_by_code(404)).to_not be_nil
      end

      it "returns the 404 record when passed as string" do
        expect(subject.find_by_code('404')).to_not be_nil
      end
    end

    context "when record is not found" do
      it "returns nil" do
        expect(subject.find_by_code(1000)).to be_nil
      end
    end
  end

  describe ".find_by_name" do
    context "when record is found" do
      it "returns the not_found record" do
        expect(subject.find_by_name('not_found')).to_not be_nil
      end
    end

    context "when record is not found" do
      it "returns nil" do
        expect(subject.find_by_name('unknown')).to be_nil
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
      expect(subject.any?).to be(true)
    end
  end

  context "with 10 records" do
    let(:collection) { (1..10).map { error } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be(true)
    end
  end
end
