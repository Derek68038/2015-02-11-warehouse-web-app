require "rubygems"
require "bundler/setup"
require "sinatra"
require "sqlite3"

DATABASE = SQLite3::Database.new("./database/warehouse_mgr.db")

require_relative "database/warehouse_methods"
require_relative "models/location"
require_relative "models/category"
require_relative "models/product"
require_relative "database/warehouse_setup"

get "/" do
  erb :homepage
end

get "/create" do  
  erb :create
end

get "/create_confirm" do
  @a = Product.new(params)
  @a.insert("products")
  erb :create_confirm  
end

get "/all" do
  erb :all
end

get "/show_all" do 
  @results1 = Product.all(params[:table_name])
  @results2 = Location.all(params[:table_name])
  @results3 = Category.all(params[:table_name])
  erb :show_all
end

get "/location" do
  erb :location
end

get "/location_results" do
  @location_show = Product.fetch_by("location_id" => params[:location_id])
  erb :location_results
end

get "/category" do
  erb :category
end

get "/category_results" do
  @category_show = Product.fetch_by("category_id" => params[:category_id])
  erb :category_results
end

get "/single" do
  erb :single
end

get "/single_results" do
  @single_show = Product.find(params[:record_id])
  erb :single_results
end

get "/edit" do
  erb :edit
end

get"/edit_results" do
  erb :edit_results
end

get "/transfer" do
  erb :transfer
end

get "/transfer_results" do
  erb :transfer_results
end

get "/delete" do
  erb :delete
end

get "/confirm_delete" do
  @delete = Product.delete(params[:id])
  erb :confirm_delete
end
