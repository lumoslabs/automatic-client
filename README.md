# Automatic Link Client

[![Build Status](https://travis-ci.org/nateklaiber/automatic-client.png)](https://travis-ci.org/nateklaiber/automatic-client)

A wrapper to consume the [Automatic
API](https://www.automatic.com/developer/documentation/). 

## Installation

Add this line to your application's Gemfile:

    gem 'automatic-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install automatic-client

## Usage

The API will require an `OAuth` `access_token` to retrieve data. You
will store this token in an `ENV` variable inside of the `.env` file:

```
API_HOST='https://api.automatic.com'
AUTOMATIC_ACCESS_TOKEN='1234'
```

### Console

```ruby
require 'automatic/client'

trips = Automatic::Client::Trips.all

# Iterate through the trips
trips.each do |trip|
  puts trip.user.id
  puts trip.vehicle.display_name

  puts trip.start_location.name
  puts trip.start_at

  puts trip.end_location.name
  puts trip.end_at

  puts trip.distance

  puts trip.fuel_cost
  puts trip.fuel_volume
  puts trip.average_mpg
  puts trip.elapsed_time
end
```

You can also use this data to get aggregate statistics as you see fit.

#### Polylines
Automatic will provide an [_encoded
polyline_](https://developers.google.com/maps/documentation/utilities/polylinealgorithm)
with the `path` attribute. This gets wrapped around the
[`polylines`](https://github.com/joshuaclayton/polylines) gem giving us
the ability to decode the polyline.

```ruby
# View a trip
trip = Automatic::Client::Trips.find_by_id('trip-id')
# => #<Automatic::Client::Trip:0x007fa36aa29760 ...>

# Return the proxy object
trip.polyline
# => #<Automatic::Client::Polyline:0x007fa36aa399f8 ...>

# Return the array of latitude and longitude parts
trip.polyline.decoded
#=> [[20,-400]]
```

### Command Line

You can also utilize a few CLI executable scripts that will allow you
to:

* View a table of the data
* Export your trips to a CSV file

You can [read more
here](https://github.com/nateklaiber/automatic-client/tree/master/bin).

## Routes

The supported endpoints are stored in `Automatic::Client.routes`. This
allows you to view all endpoints and generate a `url_for` the given
route. Routes are comprised of either a [__Uri
Template__](http://tools.ietf.org/html/rfc6570) or full path.

```ruby
require 'automatic'
# => true

# Get the URL for a templated URL with optional params
Automatic::Client.routes.route_for('trips').url_for
# => "https://api.automatic.com/v1/trips"

# Add optional parameters to expand into the URL
Automatic::Client.routes.route_for('trips').url_for(page: 1, per_page: 50)
# => "https://api.automatic.com/v1/trips?page=1&per_page=50"

# Retrieve the URI Template for a single trip route
trip_route = Automatic::Client.routes.route_for('trip')
# => #<RestlessRouter::Route:0x007f985cb7b280 @name="trip", @path="https://api.automatic.com/v1/trips/{id}", @options={:templated=>true}>

# Specify the ID for the single trip route
trip_route.url_for(id: '1234')
# => "https://api.automatic.com/v1/trips/1234"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# TODO

* Add Core Extension helpers for different data types
* Add Serializers for all types (JSON, CSV, PDF)
* Extract **configuration** into it's own object. This will allow for _class_ and _instance_ level configurations for things like **scopes**, **access_token**, **api_host**, etc. This is currently handled with global `ENV` vars.
