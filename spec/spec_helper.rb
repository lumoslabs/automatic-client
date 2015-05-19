require 'dotenv'
Dotenv.load!('.env.test') if File.exists?('.env.test')

require 'webmock/rspec'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'automatic/client'

RSpec.configure do |config|
  config.after(:suite) do
    WebMock.disable!
  end
end
