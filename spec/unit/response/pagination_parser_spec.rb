require 'spec_helper'

describe Automatic::Client::Response::PaginationParser do
  let(:uri) { 'https://api.automatic.com/v1/trips?page=2&per_page=2' }

  subject { described_class.new(uri) }

  context "with a valid URI" do
    it "returns a pagination object" do
      expect(subject.pagination).to be_a(Automatic::Client::Response::Pagination)
    end
  end

  context "with an invalid URI" do
    let(:uri) { 'invalid' }

    it "returns a pagination object" do
      expect(subject.pagination).to be_a(Automatic::Client::Response::Pagination)
    end
  end
end
