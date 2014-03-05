# Automatic Link Client

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
  puts trip.user.name
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

### Command Line

You can also utilize a few CLI executable scripts that will allow you
to:

* View a table of the data
* Export your trips to a CSV file

You can [read more
here](https://github.com/nateklaiber/automatic-client/tree/master/bin).


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# TODO

* Add Core Extension helpers for different data types
* Add Serializers for all types (JSON, CSV, PDF)
