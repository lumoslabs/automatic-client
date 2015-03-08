require 'spec_helper'

describe Automatic::Utilities::DurationCalculator do
  let(:seconds) { 1238976 }

  subject { described_class.new(seconds) }

  context "with days, hours, and minutes" do
    it "returns the #days" do
      expect(subject.days).to eq(14)
    end

    it "returns true for #days?" do
      expect(subject.days?).to be_true
    end

    it "returns the #hours" do
      expect(subject.hours).to eq(8)
    end

    it "returns true for #hours?" do
      expect(subject.hours?).to be_true
    end

    it "returns the #minutes" do
      expect(subject.minutes).to eq(9)
    end

    it "returns true for #minutes?" do
      expect(subject.minutes?).to be_true
    end

    it "returns a default formatted #to_s" do
      expect(subject.to_s).to eq("14 days 8 hours 9 minutes")
    end
  end

  context "with hours and minutes" do
    let(:seconds) { 34548 }

    it "returns 0 for the #days" do
      expect(subject.days).to eq(0)
    end

    it "returns false for #days?" do
      expect(subject.days?).to be_false
    end

    it "returns the #hours" do
      expect(subject.hours).to eq(9)
    end

    it "returns true for #hours?" do
      expect(subject.hours?).to be_true
    end

    it "returns the #minutes" do
      expect(subject.minutes).to eq(35)
    end

    it "returns true for #minutes?" do
      expect(subject.minutes?).to be_true
    end

    it "returns a default formatted #to_s" do
      expect(subject.to_s).to eq("9 hours 35 minutes")
    end
  end

  context "with minutes" do
    let(:seconds) { 3454 }

    it "returns 0 for the #days" do
      expect(subject.days).to eq(0)
    end

    it "returns false for #days?" do
      expect(subject.days?).to be_false
    end

    it "returns 0 for the #hours" do
      expect(subject.hours).to eq(0)
    end

    it "returns false for #hours?" do
      expect(subject.hours?).to be_false
    end

    it "returns the #minutes" do
      expect(subject.minutes).to eq(57)
    end

    it "returns true for #minutes?" do
      expect(subject.minutes?).to be_true
    end

    it "returns a default formatted #to_s" do
      expect(subject.to_s).to eq("57 minutes")
    end
  end
end
