require 'spec_helper'

describe Automatic::Models::UserMetadata do
  let(:user_metadata_file) do
    File.read(File.expand_path('../../../../data/user_metadata.json', __FILE__))
  end

  let(:user_metadata) do
    MultiJson.load(user_metadata_file)
  end

  let(:attributes) { user_metadata }

  subject { described_class.new(attributes) }

  context "with all values" do
    it "returns the #url" do
      expect(subject.url).to eq('https://api.automatic.com/user/U_6sQPMSEW71FQ3H/metadata/')
    end

    it "returns the #user url" do
      expect(subject.user).to eq('https://api.automatic.com/user/U_6sQPMSEW71FQ3H/')
    end

    it "returns the #firmware_version" do
      expect(subject.firmware_version).to eq('0.9.153-Oct  2 2014-16:32:04-2c35624d')
    end

    it "returns the #app_version" do
      expect(subject.app_version).to eq('1.5.1')
    end

    it "returns the #os_version" do
      expect(subject.os_version).to eq('7.0.6')
    end

    it "returns the #device_type" do
      expect(subject.device_type).to eq('iPad 2G')
    end

    it "returns the #phone_platform" do
      expect(subject.phone_platform).to eq('iOS')
    end

    it "returns false for #is_latest_app_version" do
      expect(subject.is_latest_app_version).to be_false
    end

    it "returns an alias for #latest_app_version?" do
      expect(subject.latest_app_version?).to be_false
    end
  end
end
