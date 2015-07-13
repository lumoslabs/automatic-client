module Automatic
  class ApiClient
    def vehicles
      @vehicles ||= Models::Vehicles.new(self)
    end
  end
end
