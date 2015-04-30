# Core models
require File.expand_path('../webhook/vehicle', __FILE__)
require File.expand_path('../webhook/user', __FILE__)
require File.expand_path('../webhook/button', __FILE__)
require File.expand_path('../webhook/region', __FILE__)
require File.expand_path('../webhook/trip', __FILE__)
require File.expand_path('../webhook/location', __FILE__)

require File.expand_path('../webhook/diagnostic_trouble_codes', __FILE__)
require File.expand_path('../webhook/diagnostic_trouble_code', __FILE__)

# Event models
require File.expand_path('../webhook/ignition_on', __FILE__)
require File.expand_path('../webhook/ignition_off', __FILE__)
require File.expand_path('../webhook/notification_hard_accel', __FILE__)
require File.expand_path('../webhook/notification_hard_brake', __FILE__)
require File.expand_path('../webhook/notification_speeding', __FILE__)
require File.expand_path('../webhook/parking_changed', __FILE__)
require File.expand_path('../webhook/hmi_interaction', __FILE__)
require File.expand_path('../webhook/mil_on', __FILE__)
require File.expand_path('../webhook/mil_off', __FILE__)
require File.expand_path('../webhook/region_changed', __FILE__)
require File.expand_path('../webhook/trip_finished', __FILE__)

module Automatic
  module Models
    module Webhook
    end
  end
end
