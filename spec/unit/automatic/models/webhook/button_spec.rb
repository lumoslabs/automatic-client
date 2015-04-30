require 'spec_helper'

describe Automatic::Models::Webhook::Button do
  let(:button_file) do
    File.read(File.expand_path('../../../../../data/models/webhook/button.json', __FILE__))
  end

  let(:button) do
    MultiJson.load(button_file)
  end

  let(:attributes) { button }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #id" do
      expect(subject.id).to eq('CB_PTT')
    end
  end
end
