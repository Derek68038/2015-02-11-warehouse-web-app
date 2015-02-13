require_relative "database/warehouse_methods"
# Class: Category
#
# Creates new category objects/records for categories table in warehouse_mgr 
# database.
# 
# Attributes:
# @id     - Integer: the primary key identifier for the category name.
# @name   - String: the category name.
#
# Public Methods:
# ???
#
# Private Methods:
# insert

class Category
  
  include WarehouseMethods
  
  attr_reader :id
  attr_accessor :name
  
  # Private (triggered by .new): .initialize
  # Gathers arguments (field values) in an options Hash; automatically inserts 
  # them into the categories table via private method .insert.
  #
  # Parameters:
  # options - {name: String}
  #
  # Returns: 
  # ???
  # 
  # State Changed:
  # ???
  
  def initialize(options)
    @name = options["name"]
  end
  
end