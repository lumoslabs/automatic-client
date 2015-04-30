require 'spec_helper'

describe Automatic::Models::Webhook::DiagnosticTroubleCode do
  let(:dtcs_file) do
    File.read(File.expand_path('../../../../../data/models/webhook/dtcs.json', __FILE__))
  end

  let(:dtcs) do
    MultiJson.load(dtcs_file)
  end

  let(:attributes) { dtcs }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #code" do
      expect(subject.code).to eq('P0442')
    end

    it "returns the #description" do
      expect(subject.description).to eq('Small fuel vapor leak in EVAP system')
    end

    it "returns the #unix_started_at timestamp" do
      expect(subject.unix_started_at).to eq(1430405038316)
    end

    it "returns the #started_at UTC timestamp" do
      expected = '2015-04-30 14:43:58 UTC'
      expect(subject.started_at.to_s).to eq(expected)
    end
  end
end
