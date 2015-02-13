#require 'pry'
require 'minitest/autorun'

require "sqlite3"

DATABASE = SQLite3::Database.new("warehouse_test.db")
require_relative "warehouse_setup.rb"

require_relative 'product.rb'
require_relative 'location.rb'
require_relative 'category.rb'
require_relative 'warehouse_methods.rb'

class WarehouseTest < Minitest::Test
  
  include WarehouseMethods
  
  def setup
    DATABASE.execute("DELETE FROM products")
    DATABASE.execute("DELETE FROM locations")
    DATABASE.execute("DELETE FROM categories")
  end
  
  def test_product_creation
    product = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
    
    product.insert("products")   
    results = DATABASE.execute("SELECT description FROM products WHERE id = 
                                #{product.id}")
    
    added_product = results[0]
    
    assert_equal("Hello", added_product["description"])
  end
  
  def test_location_creation
    location = Location.new({"city" => "Omaha"})
    
    location.insert("locations")   
    results = DATABASE.execute("SELECT city FROM locations WHERE id = 
                                #{location.id}")
    
    added_location = results[0]
    
    assert_equal("Omaha", added_location["city"])
  end
  
  def test_category_creation
    category = Category.new({"name" => "Movie"})
    
    category.insert("categories")   
    results = DATABASE.execute("SELECT name FROM categories WHERE id = 
                                #{category.id}")
    
    added_category = results[0]
    
    assert_equal("Movie", added_category["name"])
  end
  
  def test_all_method
    location = Location.new({"city" => "Omaha"})
    category = Category.new({"name" => "Book"})
    product = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
    
    location.insert("locations")
    category.insert("categories")
    product.insert("products")
    
    assert_equal(1, Location.all("locations").length)
    assert_equal(1, Category.all("categories").length)
    assert_equal(1, Product.all("products").length)
  end
  
  def test_find_method
    location = Location.new({"city" => "Omaha"})
    category = Category.new({"name" => "Book"})
    product = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
   
    location.insert("locations")
    category.insert("categories")
    product.insert("products")
    
    results1 = Product.find("products", 1)
    results2 = Location.find("locations", 1)
    results3 = Category.find("categories", 1) 
    
    assert_equal(10, results1.cost)
    assert_equal("Omaha", results2.city)
    assert_equal("Book", results3.name)                        
  end
  
  def test_delete_method
    product1 = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
                            
    product2 = Product.new({"serial_number" => 2, "description" => "Goodbye", 
                            "quantity" => 8, "cost" => 12, "location_id" => 1,
                            "category_id" => 2})
                            
    product1.insert("products")
    product2.insert("products")
    
    Product.delete("products", 1)
    
    assert_equal(1, Product.all("products").length)
  end
  
  def test_save_method
    product = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
                            
    product.insert("products")
    
    product.quantity = 10
    
    product.save("products")
    
    assert_equal(10, product.quantity)
  end
  
  def test_insert_method
    product = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
                            
    product.insert("products")
    
   assert_equal(1, Product.all("products").length) 
 end
 
 def test_fetch_by_method
   product1 = Product.new({"serial_number" => 1, "description" => "Hello", 
                           "quantity" => 5, "cost" => 10, "location_id" => 1,
                           "category_id" => 3})
                           
   product2 = Product.new({"serial_number" => 2, "description" => "Goodbye", 
                           "quantity" => 8, "cost" => 12, "location_id" => 1,
                           "category_id" => 2})
   
   product3 = Product.new({"serial_number" => 3, "description" => "Hi again", 
                           "quantity" => 10, "cost" => 15, "location_id" => 2,
                           "category_id" => 2})
  
   product1.insert("products")
   product2.insert("products")
   product3.insert("products")
   
   assert_equal(2, Product.fetch_by("location_id" => 1).length)
 end
 
end

#binding.pry