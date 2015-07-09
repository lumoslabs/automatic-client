module Automatic
  class ApiClient
    def trips
      ClientDelegator.new(self, Models::Trips)
    end
  end
end
