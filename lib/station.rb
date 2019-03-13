class Station
  attr_reader :zone ,:name
  def initialize(name: 'Old Street', zone: 1)
    @name = name
    @zone = zone
  end
end
