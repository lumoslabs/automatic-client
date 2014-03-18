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

## Polylines
Automatic will provide an [_encoded
polyline_](https://developers.google.com/maps/documentation/utilities/polylinealgorithm)
with the `path` attribute. This gets wrapped around the
[`polylines`](https://github.com/joshuaclayton/polylines) gem giving us
the ability to decode the polyline.

```ruby
# View a trip
trip = Automatic::Client::Trips.find_by_id('trip-id')
# => #<Automatic::Client::Trip:0x007fa36aa29760 ...>

trip.polyline
=> #<Automatic::Client::Polyline:0x007fa36aa399f8 @path="cfjvFbikpNdAWhJwCvIoCwInCiJvCsAZm@Da@@w@CcBWRaCa@?KBmDlBsGbDqDjAiK|CMg@kEgPg@wBsAsFoLrGkJzEgGjDyBnAyAuFwBuIkCxAqFxCgInE_HxDqBwHm@{A?{CEsAOm@eAqAO]Im@a@iBwBgL?kCtBF">
>> trip.polyline.decoded
=> [[40.52594, -81.49154], [40.52559, -81.49142], [40.52378, -81.49066], [40.52206, -81.48994], [40.52378, -81.49066], [40.52559, -81.49142], [40.52601, -81.49156], [40.52624, -81.49159], [40.52641, -81.4916], [40.526689999999995, -81.49158], [40.52719, -81.49146], [40.527089999999994, -81.49081000000001], [40.52725999999999, -81.49081000000001], [40.52731999999999, -81.49083000000002], [40.52818999999999, -81.49138000000002], [40.529569999999985, -81.49220000000003], [40.530459999999984, -81.49258000000003], [40.532429999999984, -81.49337000000003], [40.532499999999985, -81.49317000000002], [40.53351999999998, -81.49041000000003], [40.53371999999998, -81.48981000000002], [40.53413999999998, -81.48859000000002], [40.53629999999998, -81.48997000000001], [40.538119999999985, -81.49107000000001], [40.539439999999985, -81.49193000000001], [40.54004999999999, -81.49233000000001], [40.54049999999999, -81.4911], [40.541099999999986, -81.48939], [40.54179999999999, -81.48984], [40.54300999999999, -81.49061], [40.54464999999999, -81.49165], [40.54608999999999, -81.49258], [40.546659999999996, -81.49102], [40.54689, -81.49056], [40.54689, -81.48978], [40.54692, -81.48935999999999], [40.547, -81.48912999999999], [40.547349999999994, -81.48871999999999], [40.54742999999999, -81.48856999999998], [40.54747999999999, -81.48833999999998], [40.54764999999999, -81.48780999999998], [40.54824999999999, -81.48568999999998], [40.54824999999999, -81.48498999999998], [40.547659999999986, -81.48502999999998]]
>> 
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
require 'automatic/client'
=> true

Automatic::Client.routes.route_for('trips').url_for
=> "https://api.automatic.com/v1/trips"

Automatic::Client.routes.route_for('trips').url_for(page: 1, per_page: 50)
=> "https://api.automatic.com/v1/trips?page=1&per_page=50"
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
