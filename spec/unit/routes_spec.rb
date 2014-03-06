require 'spec_helper'

describe Automatic::Routes do
  let(:trips_route) { Automatic::Route.new('trips', 'http://api.example.com/trips') }
  let(:trip_route) { Automatic::Route.new('trip', 'http://api.example.com/trips/{id}', templated: true) }
  let(:routes)  { [trips_route, trip_route] }

  subject { described_class.new }

  before(:each) do
    routes.each do |route|
      subject.add_route(route)
    end
  end

  context "with routes" do
    it "returns true for #routes?" do
      expect(subject.routes?).to be_true
    end

    it "returns the route by the name of 'trips'" do
      expect(subject.route_for('trips')).to eq(trips_route)
    end

    it "returns the route by the name of 'trip'" do
      expect(subject.route_for('trip')).to eq(trip_route)
    end

    context "ensure uniqueness by name" do
      let(:routes) { [] }

      it "does not add a route by the same name" do
        subject.add_route(trips_route)
        subject.add_route(trips_route)
        expect(subject.routes.count).to eq(1)
      end
    end
  end

  context "with errors" do
    it "raises an InvalidRouteError if object does not respond to #url_for" do
      lambda { subject.add_route(nil) }.should raise_error(Automatic::Routes::InvalidRouteError)
    end
  end

  context "without routes" do
    let(:routes) { [] }

    it "returns false for #routes?" do
      expect(subject.routes?).to be_false
    end

    it "returns nil when searching by name" do
      expect(subject.route_for('')).to be_nil
    end
  end
end
