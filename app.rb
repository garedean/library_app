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

get('/reset') do
  Book.clear
  Author.clear
  redirect to('/')
end

get('/books/home') do
  @found_books = Book.find(title: params.fetch('title', []))
  erb(:books_home)
end

get('/books/new') do
  erb(:book_form)
end

get('/books') do
  @found_books = Book.all

  erb(:books)
end

post('/books') do
  title = params.fetch("title")
  first_name1 = params.fetch('first_name1', nil)
  last_name1 = params.fetch('last_name1', nil)
  first_name2 = params.fetch('first_name2', nil)
  last_name2 = params.fetch('last_name2', nil)

  @book = Book.new(id: nil, title: title)
  @book.save
  author1 = Author.find(first_name: first_name1, last_name: last_name1)
  author2 = Author.find(first_name: first_name2, last_name: last_name2)
  if author1 == []
    author1 = Author.new(id: nil, first_name: first_name1, last_name: last_name1)
    author1.save
    @book.add_author([author1])
  end
  if author2 == []
    author2 = Author.new(id: nil, first_name: first_name2, last_name: last_name2)
    author2.save
    @book.add_author([author2])
  end

  @found_books = Book.find(title: params.fetch('title', []))
  redirect to("/books/#{@book.id}")
end

get('/books/lookup') do
  erb(:book_lookup)
end

post('/books/lookup/results') do
  title = params.fetch("title")

  #redirect to('/books') if title.empty?

  @found_books = title.empty? ? Book.all : Book.find(title: title)

  erb(:book_results)
end

get('/books/:id') do
  id    = params["id"].to_i
  @book = Book.find(id: id).first
  erb(:book)
end

delete('/books/:id') do
  id = params["id"].to_i
  book = Book.find(id: id).first
  book.delete

  redirect to('/books/lookup')
end

post('/authors') do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  @author = Author.new(id: nil, first_name: first_name, last_name: last_name)
  @author.save()
  erb(:authors)
end

patch('/books/:id') do
  id                = params['id'].to_i
  title             = params['title']
  author_first_name = params['author_first_name']
  author_last_name  = params['author_last_name']

  book = Book.find(id: id).first
  book.update(title: title)
  redirect to('/books/lookup')
end

get('/visiter_home') do
  erb(:visiter_home)
end
