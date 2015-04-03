require 'spec_helper'

describe Automatic::Utilities::DurationCalculator do
  let(:seconds) { 1238976 }

  subject { described_class.new(seconds) }

  context "exact times" do
    describe "59 seconds" do
      let(:seconds) { 59 }

      it "returns 0 for the #days" do
        expect(subject.days).to eq(0)
      end

      it "returns false for #days?" do
        expect(subject.days?).to be(false)
      end

      it "returns 0 for the #hours" do
        expect(subject.hours).to eq(0)
      end

      it "returns false for #hours?" do
        expect(subject.hours?).to be(false)
      end

      it "returns 0 for the #minutes" do
        expect(subject.minutes).to eq(0)
      end

      it "returns false for #minutes?" do
        expect(subject.minutes?).to be(false)
      end

      it "returns the #seconds" do
        expect(subject.seconds).to eq(59)
      end

      it "returns a default formatted #to_s" do
        expect(subject.to_s).to eq("59 seconds")
      end
    end

    describe "1 minute" do
      let(:seconds) { 60 }

      it "returns 0 for the #days" do
        expect(subject.days).to eq(0)
      end

      it "returns false for #days?" do
        expect(subject.days?).to be(false)
      end

      it "returns 0 for the #hours" do
        expect(subject.hours).to eq(0)
      end

      it "returns false for #hours?" do
        expect(subject.hours?).to be(false)
      end

      it "returns the #minutes" do
        expect(subject.minutes).to eq(1)
      end

      it "returns true for #minutes?" do
        expect(subject.minutes?).to be_true
      end

      it "returns a default formatted #to_s" do
        expect(subject.to_s).to eq("1 minutes")
      end
    end

    describe "60 minutes" do
      let(:seconds) { 3600 }

      it "returns 0 for the #days" do
        expect(subject.days).to eq(0)
      end

      it "returns false for #days?" do
        expect(subject.days?).to be(false)
      end

      it "returns the #hours" do
        expect(subject.hours).to eq(1)
      end

      it "returns true for #hours?" do
        expect(subject.hours?).to be_true
      end

      it "returns the #minutes" do
        expect(subject.minutes).to eq(0)
      end

      it "returns true for #minutes?" do
        expect(subject.minutes?).to be_true
      end

      it "returns a default formatted #to_s" do
        expect(subject.to_s).to eq("1 hours 0 minutes")
      end
    end

    describe "24 hours" do
      let(:seconds) { 86400 }

      it "returns the #days" do
        expect(subject.days).to eq(1)
      end

      it "returns true for #days?" do
        expect(subject.days?).to be_true
      end

      it "returns 0 for the #hours" do
        expect(subject.hours).to eq(0)
      end

      it "returns true for #hours?" do
        expect(subject.hours?).to be_true
      end

      it "returns the #minutes" do
        expect(subject.minutes).to eq(0)
      end

      it "returns true for #minutes?" do
        expect(subject.minutes?).to be_true
      end

      it "returns a default formatted #to_s" do
        expect(subject.to_s).to eq("1 days 0 hours 0 minutes")
      end
    end
  end

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
      expect(subject.days?).to be(false)
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
      expect(subject.days?).to be(false)
    end

    it "returns 0 for the #hours" do
      expect(subject.hours).to eq(0)
    end

    it "returns false for #hours?" do
      expect(subject.hours?).to be(false)
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
