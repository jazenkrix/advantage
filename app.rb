require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/partial'
require 'sqlite3'
require 'require_all'
require 'shotgun'
require 'tux'
require 'json'
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
  @title = 'Advantage'
  erb :index
end

post '/encounter/new' do
  @encounter = Encounter.find_or_create_by(name: params[:name])
  @encounter.update(description: params[:desc])
end

post '/player/new' do
  @creature = Creature.find_or_create_by(name: params[:name])
  @creature.update(pc: true)
end

post '/npc/new' do
  @creature = Creature.find_or_create_by(name: params[:name])
  @creature.update(npc: true)
end

post '/monster/new' do
  @creature = Creature.find_or_create_by(name: params[:name])
  @creature.update(size: params[:size], category: params[:type], subtype: params[:subtype],
                   alignment: params[:alignment], monster: true)
end

get '/statblock/:id' do
  @creature = Creature.find(params[:id])
  @title = @creature.name
  erb :statblock
end

get '/encounters' do
  @title = 'Encounters'
  erb :encounters
end

get '/encounter/:id' do
  @encounter = Encounter.find(params[:id])
  @title = "Encounter: #{@encounter.name}"
  erb :encounter
end

post "/edit_initiative/:id" do
  params[:initiative].each_pair do |creature_id, initiative|
    combatant = Combatant.where(encounter_id: params[:id], creature_id: creature_id).first
    combatant.update(initiative: initiative)
  end
  redirect "/encounter/#{params[:id]}"
end

get '/dice' do
  erb :dice
end

get '/creatures' do
  content_type :json
  keyword = "%#{params[:term]}%"
  @creature_names = Creature.where("name LIKE ?", keyword).collect(&:name)
  @creature_names.to_json
end

