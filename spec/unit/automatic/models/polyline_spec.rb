require 'spec_helper'

describe Automatic::Models::Polyline do
  let(:path) { '{xoeFlkjjVmOhBsA_ToEir@gDch@sAgSi@cIi@qI~IgAn@w@DEKMMOCOAEeAyAcDqEwEmG]c@g@YuCyD@I@IpAiBlAaBpAkBcHuJeGiIgFeHgTyYWa@DG' }

  subject { described_class.new(path) }

  context "with valid path" do
    it "responds to #encoded" do
      expect(subject).to respond_to(:encoded)
    end

    it "responds to #decoded" do
      expect(subject).to respond_to(:decoded)
    end

    it "returns the #encoded path" do
      expect(subject.encoded).to eq('{xoeFlkjjVmOhBsA_ToEir@gDch@sAgSi@cIi@qI~IgAn@w@DEKMMOCOAEeAyAcDqEwEmG]c@g@YuCyD@I@IpAiBlAaBpAkBcHuJeGiIgFeHgTyYWa@DG')
    end

    it "returns the #decoded path" do
      expected = [[37.76926, -122.44679], [37.771890000000006, -122.44731999999999], [37.772310000000004, -122.44395999999999], [37.77335000000001, -122.43574999999998], [37.774190000000004, -122.42916999999998], [37.77461, -122.42592999999998], [37.774820000000005, -122.42430999999998], [37.77503000000001, -122.42261999999998], [37.77327000000001, -122.42225999999998], [37.77303000000001, -122.42197999999998], [37.77300000000001, -122.42194999999998], [37.77306000000001, -122.42187999999999], [37.77313000000001, -122.42179999999999], [37.77315000000001, -122.42172], [37.77316000000001, -122.42169], [37.77351000000001, -122.42124], [37.774330000000006, -122.42018999999999], [37.77541000000001, -122.41883999999999], [37.775560000000006, -122.41865999999999], [37.775760000000005, -122.41852999999999], [37.77651, -122.4176], [37.7765, -122.41754999999999], [37.776489999999995, -122.41749999999999], [37.77607999999999, -122.41696999999999], [37.77568999999999, -122.41647999999999], [37.77527999999999, -122.41593999999999], [37.77673999999999, -122.41407], [37.778049999999986, -122.41242], [37.779209999999985, -122.41095], [37.782609999999984, -122.40666], [37.78272999999999, -122.40649], [37.782699999999984, -122.40645]]
      expect(subject.decoded).to eq(expected)
    end
  end

  context "with invalid path" do
    let(:path) { 'invalid' }

    it "returns a nil collection for the #decoded path" do
      expected = [[nil, nil]]
      expect(subject.decoded).to eq(expected)
    end
  end
end
