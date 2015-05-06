require('sinatra')
require('sinatra/reloader')
require('./')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect(dbname: 'library')

get('/') do
  erb(:index)
end
