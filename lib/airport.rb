require_relative "weather"

class Airport
  DEFAULT_CAPACITY = 20
  ERROR = {
    stormy: "No can do. It's too stormy, cap'n!",
    full: "Not enough room. Please circle the airport awkwardly.",
    plane_missing: "404 plane not found.",
    plane_docked: "The plane has already landed!"
  }.freeze

  attr_reader :capacity

  def initialize(capacity = DEFAULT_CAPACITY, weather = Weather.new)
    @capacity = capacity
    @weather = weather
    @planes = []
  end

  def land_plane(plane)
    fail ERROR[:stormy] if @weather.stormy?
    fail ERROR[:full] if full?
    fail ERROR[:plane_docked] if docked?(plane)
    @planes << plane
  end

  def take_off(plane)
    fail ERROR[:stormy] if @weather.stormy?
    fail ERROR[:plane_missing] unless docked?(plane)
    @planes.delete(plane)
  end

  private

    def docked?(plane)
      @planes.include?(plane)
    end

    def empty?
      @planes.empty?
    end

    def full?
      @planes.size >= @capacity
    end
end
