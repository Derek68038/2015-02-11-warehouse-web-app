module WarehouseMethods
  
  def self.included(base)
     base.extend WarehouseClassMethods
  end
  
  module WarehouseClassMethods
    # Input all class methods.
    
    # Public: .all
    # Get all the records in the products table.
    #
    # Parameters:
    # None
    #
    # Returns: 
    # Array: Records from the products table displaying all fields.
    #
    # State Changes:
    # None
    
    def all(table_name)
      DATABASE.execute("SELECT * FROM #{table_name}")
    end
    
    # Public: .find
    # Fetch a given record from any table.
    #
    # Parameters:
    # record_id - Integer: The product's ID in the table.
    #
    # Returns:
    # Array containing one row as a hash.
    #
    # State Changes:
    # None
    
    def find(table_name, record_id) 
      results = DATABASE.execute("SELECT * FROM #{table_name} WHERE id = #{record_id}")
      record_details = results[0] # hash of the record's details.
      record_details
      #self.new(record_details)
    end
      
    # Public: .delete
    # Syntax to delete a record in the products table who's id matches the 
    # inputted record id.
    #
    # Parameters:
    # record_id - Integer: The id which you want to delete.
    #
    # Returns:
    # Empty array.
    #
    # State Changes:
    # None
    
    def delete(record_id)
      DATABASE.execute("DELETE FROM products WHERE id = #{record_id}")
    end
    
  end
  
# Input all instance methods.
  
  # Public: #save
  # Updates the products table to changes made to an existing object in ruby.
  # 
  # Parameters:
  # None
  #
  # Returns:
  # Empty Array. Updates sql database with changes.
  #
  # State Changes:
  # Pushes all attributes to array while deleting @ symbol.
  
  def save(table_name)
    attributes = []
    
    instance_variables.each do |i|
      attributes << i.to_s.delete("@")
    end

    query_components_array = []

    attributes.each do |a|
      value = self.send(a)
  
      if value.is_a?(Integer)
        query_components_array << "#{a} = #{value}"
      else
        query_components_array << "#{a} = '#{value}'"
      end
    end

    query_string = query_components_array.join(", ")
    # example: name = 'Sumeet', age = 75, hometown = 'San Diego'
    
    DATABASE.execute("UPDATE #{table_name} SET #{query_string} WHERE id = #{id}")
  end
  
  # Public: #insert
  # Syntax to enter the Ruby object's arguments as a records' field values via 
  # sqlite3.
  #
  # Parameters:
  # None
  #
  # Returns: 
  # Integer - @id, "id" field value, generated by table upon creation and 
  # pulled from the record.
  # 
  # State ChangeS:
  # ???
  
  def insert(table_name)
    if table_name == "products"
      DATABASE.execute("INSERT INTO products (serial_number, description, 
                      quantity, cost, location_id, category_id) VALUES 
                      (#{@serial_number}, '#{@description}', #{@quantity}, 
                      #{@cost}, #{@location_id}, #{@category_id})")
      @id = DATABASE.last_insert_row_id
    elsif table_name == "locations"
      DATABASE.execute("INSERT INTO locations (city) VALUES ('#{@city}')")
      @id = DATABASE.last_insert_row_id
    elsif table_name == "categories"
      DATABASE.execute("INSERT INTO categories (name) VALUES ('#{@name}')")
      @id = DATABASE.last_insert_row_id
    end
  end 
  
end
