require_relative "database/warehouse_methods"
# Class: Location
#
# Creates new location objects/records for locations table in warehouse_mgr 
# database
# 
# Attributes:
# @id     - Integer: the primary key identifier for location city.
# @city   - String: the city name. 
#
# Public Methods:
# .all
#
# Private Methods:
# #insert

class Location
  
  include WarehouseMethods
  
  attr_reader :id
  attr_accessor :city
  
  # Private (triggered by .new): .initialize
  # Gathers arguments (field values) in an options Hash; automatically inserts 
  # them into the locations table via private method .insert.
  #
  # Parameters:
  # options - {city: String}
  #
  # Returns: 
  # ???
  # 
  # State ChangeS:
  # ???
  
  def initialize(options)
    @city = options["city"]
  end
  
end