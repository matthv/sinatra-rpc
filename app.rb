require 'bundler/setup'
Bundler.require

require 'sinatra'
require 'json'
require 'forest_admin_rpc_agent'

set :port, 4567

def create_agent
  ForestAdminRpcAgent::Agent.new(host: 'localhost', port: 50051)
rescue StandardError => e
  puts "[ERROR] Could not create agent - cannot connect to gRPC server: #{e.message}"
  nil
end

# home
get '/' do
  '<h1>Mini Client RPC</h1>
   <p><a href="/users">User lists</a></p>'
end

# users
get '/users' do
  agent = create_agent
  return "<h1>Erreur</h1><p>Could not connect to gRPC server.</p>" unless agent

  users = agent.list_users
  '<h1>User lists</h1>' +
    users.map { |u| "<p>#{u.id}: #{u.first_name} #{u.last_name} (#{u.email})</p>" }.join
end
