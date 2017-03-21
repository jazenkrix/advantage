require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/partial'
require 'sqlite3'
require 'require_all'
require 'shotgun'
require 'tux'
# require 'recursive-open-struct'

# require_rel 'models'
# require_rel 'routes'
# require_rel 'lib'

enable :sessions
set :session_secret, '^t001box'
set :database, { adapter: 'sqlite3', database: 'advantage.db' }
set :partial_template_engine, :erb

get '/' do
  erb :index
end
