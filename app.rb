require 'bundler/setup'
Bundler.require

require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'httparty'
require 'forest_admin_rpc_agent'

require './models/product'
require './models/order'

set :database, { adapter: 'sqlite3', database: 'db/development.sqlite3' }
set :port, 4567

API_BASE_URL = 'http://localhost:5000'

def create_agent(path)
  response = HTTParty.get("#{API_BASE_URL}#{path}")
  return nil unless response.success?

  JSON.parse(response.body)
rescue StandardError => e
  puts "[ERROR] Could not connect to HTTP server: #{e.message}"
  nil
end

# Breadcrumb
def breadcrumb(paths)
  '<p>' + paths.map.with_index do |(name, url), index|
    if index == paths.length - 1
      name
    else
      "<a href=\"#{url}\">#{name}</a>"
    end
  end.join(' > ') + '</p>'
end

# Home
get '/' do
  breadcrumb([%w[Home /]]) +
    '<h1>Mini Client RPC</h1>
     <p><a href="/models">Models</a></p>
     <p><a href="/rpc">RPC</a></p>'
end

# Models
get '/models' do
  breadcrumb([%w[Home /], %w[Models /models]]) +
    '<h1>Models</h1>
     <p><a href="/models/products">Products</a></p>
     <p><a href="/models/orders">Orders</a></p>'
end

# Products
get '/models/products' do
  products = Product.all
  breadcrumb([%w[Home /], %w[Models /models], %w[Products /models/products]]) +
    '<h1>Products</h1>' +
    products.map { |p| "<p>#{p.id}: #{p.name} - $#{p.price}</p>" }.join
end

# Orders
get '/models/orders' do
  orders = Order.includes(:product).all
  breadcrumb([%w[Home /], %w[Models /models], %w[Orders /models/orders]]) +
    '<h1>Orders</h1>' +
    orders.map do |o|
      "<p>Order ##{o.id}: #{o.customer_name} ordered #{o.quantity}x #{o.product&.name}</p>"
    end.join
end

######################### RPC call #########################
get '/rpc' do
  breadcrumb([%w[Home /], %w[RPC /rpc]]) +
    '<h1>RPC</h1>
     <p><a href="/rpc/users">users</a></p>'
end

# Users
get '/rpc/users' do
  users = create_agent('/users')

  puts "DEBUG users: #{users.inspect}"
  return "<h1>Error</h1><p>Could not connect to HTTP server.</p>" unless users

  breadcrumb([%w[Home /], %w[RPC /rpc], %w[Users /rpc/users]]) +
    '<h1>User lists</h1>' +
    users.map { |u| "<p>#{u['id']}: #{u['first_name']} #{u['last_name']} (#{u['email']})</p>" }.join
end