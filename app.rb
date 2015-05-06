require('sinatra')
require('sinatra/reloader')
require('./lib/book.rb')
require('./lib/author.rb')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect(dbname: 'library')

get('/') do
  erb(:index)
end

get('/books') do
  @found_books = Book.find(title: params.fetch('title', []))
  erb(:books)
end

post('/books') do
  title = params.fetch("title")
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')

  author = Author.find(first_name: first_name, last_name: last_name)
  if author = []
    author = Author.new(id: nil, first_name: first_name, last_name: last_name)
    author.save
  end
  @book = Book.new(id: nil, title: title, author_id: author.id.to_i)
  @book.save

  @found_books = Book.find(title: params.fetch('title', []))
  erb(:books)
end

post('/books/search_results') do
  title = params.fetch("title")

  @found_books = Book.find(title: title)

  erb(:books)
end

get('/patrons') do
  erb(:patrons)
end

get('/books/new') do
  erb(:book_form)
end

post('/authors') do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  @author = Author.new(id: nil, first_name: first_name, last_name: last_name)
  @author.save()
  erb(:authors)
end
