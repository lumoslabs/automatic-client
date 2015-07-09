module Automatic
  class ApiClient
    def vehicles
      ClientDelegator.new(self, Models::Vehicles)
    end
  end
end
