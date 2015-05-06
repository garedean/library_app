require('sinatra')
require('sinatra/reloader')
require('./lib/book.rb')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect(dbname: 'library')

get('/') do
  erb(:index)
end

get('/books') do
  @books = Book.find(title: params.fetch('title', []))
  erb(:books)
end

post('/books') do
  @books = Book.find(title: params['title'])
  erb(:books)
end

get('/patrons') do
  erb(:patrons)
end
