module Automatic
  class ApiClient
    def trips
      @trips ||= Models::Trips.new(self)
    end
  end
end
