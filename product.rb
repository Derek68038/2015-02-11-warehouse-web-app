require_relative "warehouse_methods"
#require_relative "instance_methods"
# Class: Product
#
# Creates new product objects/records for products table in warehouse_mgr 
# database.
# 
# Attributes:
# @id              - Integer: Unique identifier for product (primary key).
# @serial_number   - Integer: Serial number for product. 
# @description     - String: Description/title of product.
# @quantity        - Integer: Number of items of product.
# @cost            - Integer: Cost of product (based on quantity).
# @location_id     - Integer: Location site for product (foreign key).
# @category_id     - Integer: Category type for product (foreign key).
#
# Public Methods:
# ???
#
# Private Methods:
# insert

class Product
  
  include WarehouseMethods
  
  attr_reader :id
  attr_accessor :serial_number, :quantity, :description, :cost, :location_id,
                :category_id, :new
  
  # Private (triggered by .new): .initialize
  # Gathers arguments (field values) in an options Hash; automatically inserts 
  # them into the products table via private method .insert.
  #
  # Parameters:
  # options - {serial_number: Integer, name: String, description: String,     
  # quantity: Integer, cost: Integer, location_id: Integer, category_id: 
  # Integer}.
  #
  # Returns: 
  # ???
  # 
  # State Changes:
  # ???
  
  def initialize(options)
    @serial_number    = options["serial_number"]
    @description      = options["description"]
    @quantity         = options["quantity"]
    @cost             = options["cost"]
    @location_id      = options["location_id"]
    @category_id      = options["category_id"]
  end
  
  # Public .fetch_products_from_location
  # Gets a list of products with a given location id.
  #
  # Parameters:
  # location_id - Integer: The location id to search for.
  #
  # Returns:
  # Array of product objects with the given location id.
  #
  # State Changes:
  # None
  
  def self.fetch_by(options) #ex: Product.fetch_by("location_id" => 2)
    # options.length == 1
    v = []
    k = []
    options.each_key {|key| k << "#{key}"}
    options.each_value {|value| v << "#{value}"}

    field = k[0].to_s
    search_value = v[0].to_i

    search_query = "SELECT * FROM products WHERE #{field} = #{search_value}"

    results = DATABASE.execute("#{search_query}")
    
    results

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end

    x = 0

    until x == results_as_objects.length
      puts "Description: '#{results_as_objects[x].description}'".ljust(50) +
            "\tQuantity: #{results_as_objects[x].quantity}".rjust(15)
      x+=1
    end

    results_as_objects # need to return this for testing purposes mainly
                       # doesn't seem to affect any of the output in driver
  end
  
end