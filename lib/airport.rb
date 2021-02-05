require 'weather.rb'

class Airport

  attr_reader :hangar, :weather
  attr_accessor :capacity


  MAX_CAPACITY = 5

  def initialize(capacity = MAX_CAPACITY, weather = Weather.new)
    @weather = weather
    @capacity = capacity
    @hangar = []
  end

  def land_plane(plane)
    if @hangar.length >= @capacity && @weather.status == "stormy"
      raise "you can not land due to stormy conditions. Aiport is also full"
    elsif @weather.status == "stormy"
      raise "you can not land due to stormy weather"
    elsif @hangar.length >= @capacity
      raise "the airports max capacity of #{@capacity} has been reached, do not land"
    end
    @hangar << (plane)
  end

  def plane_take_off(plane)
    if @weather.status == "stormy"
      raise "you can not fly due to bad weather"
    end
    @hangar.delete(plane)
  end

  def override_max_capacity(num)
    @capacity = num
  end
end
