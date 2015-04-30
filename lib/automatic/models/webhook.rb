# Core models
require File.expand_path('../webhook/vehicle', __FILE__)
require File.expand_path('../webhook/user', __FILE__)

# Event models
require File.expand_path('../webhook/ignition_on', __FILE__)
require File.expand_path('../webhook/ignition_off', __FILE__)
require File.expand_path('../webhook/notification_hard_accel', __FILE__)
require File.expand_path('../webhook/notification_hard_brake', __FILE__)
require File.expand_path('../webhook/notification_speeding', __FILE__)
require File.expand_path('../webhook/parking_changed', __FILE__)

module Automatic
  module Models
    module Webhook
    end
  end
end
