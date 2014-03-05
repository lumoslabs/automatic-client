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

The planned interaction will look like:

### Console

```ruby

connection =
Automatic::Client::Connection.new('https://api.automatic.com')
trips      = connection.trips

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

```
bin/trips # List all trips
bin/trips --id '1234' # View a specific trip
bin/vehicles # List all vehicles
bin/vehicles --id '1234' # View a specific vehicle
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
