require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/partial'
require 'sqlite3'
require 'require_all'
require 'shotgun'
require 'tux'
# require 'recursive-open-struct'
require_relative 'public/data/monsters'
require_rel 'models'
require_rel 'routes'
# require_rel 'lib'

enable :sessions
set :session_secret, '^t001box'
set :database, { adapter: 'sqlite3', database: 'advantage.db' }
set :partial_template_engine, :erb

helpers do

  def calculate_modifier(score)
    modifier = (score - 10) / 2
    return 0 if modifier == 0
    modifier
  end

  def format_modifier(score)
    modifier = calculate_modifier(score.to_i)
    modifier >= 0 ? "+#{modifier}" : "-#{modifier.abs}"
  end

end

get '/' do
  erb :index
end
