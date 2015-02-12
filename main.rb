require "sinatra"
require "sqlite3"

DATABASE = SQLite3::Database.new("warehouse_mgr.db")

require_relative "location.rb"
require_relative "category.rb"
require_relative "product.rb"
require_relative "warehouse_setup.rb"

get "/" do
  # Find the ERB file in views/welcome.erb and return it.
  erb :homepage
end

get "/create" do  
  erb :create
end

get "/create_confirm" do
  a = Product.new(params)
  a.insert("products")
  erb :create_confirm  
end

get "/all" do
  erb :all
end

get "/show_all" do 
  @results = Product.all(params[:table_name])
  erb :show_all
end

get "/location" do
  erb :location
end

get "/location_results" do
  @location_show = Product.fetch_by("location_id" => params[:location_id])
  erb :location_results
end

get "/single" do
  erb :single
end

get"/single_results" do
  @single_show = Product.find(params[:table_name], params[:record_id])
  erb :single_results
end

get "/edit" do
  erb :edit
end

get "/transfer" do
  erb :transfer
end

get "/delete" do
  erb :delete
end

get "/confirm_delete" do
  Product.delete(params[:id])
  erb :confirm_delete
end