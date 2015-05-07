require('pry')
#require('author.rb')

class Book
  attr_reader(:id, :title)

  def initialize(attributes)
    @title     = attributes[:title]
    @id        = attributes[:id]
  end

  def ==(other_book)
    title.==(other_book.title)
  end

  def add_author(authors)
    authors.each do |author|
      DB.exec("INSERT INTO books_authors (book_id, author_id) VALUES (#{@id}, #{author.id})")
    end
  end

  def authors
    returned_author_ids = DB.exec("SELECT author_id FROM books_authors WHERE book_id = #{@id};")
    authors = []

    returned_author_ids.each do |author_id|
      author = Author.find(id: author_id["author_id"].to_i)
      authors << author.first
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first['id'].to_i
    DB.exec("INSERT INTO copies (book_id, checked_out) VALUES (#{@id}, 'f');")
  end

  def self.clear
    DB.exec("DELETE FROM books;")
    DB.exec("DELETE FROM books_authors;")
  end

  def update(attributes)
    @title     = attributes.fetch(:title, nil)
    @authors   = attributes.fetch(:authors, nil)

    if @title
      DB.exec("UPDATE books SET title = '#{title}' WHERE id = #{@id};")
    end

    if @authors
      # Delete all rows from books_authors for this book
      DB.exec("DELETE FROM books_authors WHERE book_id = #{@id};")
      add_author(@authors)
    end
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
    DB.exec("DELETE FROM books_authors WHERE book_id = #{@id};")
    DB.exec("DELETE FROM copies WHERE book_id = #{@id}")
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |book|
      title     = book["title"]
      id        = book["id"].to_i
      books << Book.new(id: id, title: title)
    end
    books
  end

  def self.find(attributes)
    id        = attributes.fetch(:id, nil)
    title     = attributes.fetch(:title, nil)

    result = nil

    if id
      result = DB.exec("SELECT * FROM books WHERE id = #{id.to_i}")
    elsif title
      result = DB.exec("SELECT * FROM books WHERE title = '#{title}'")
    end

    unless result.num_tuples.zero?
      id        = result.first["id"].to_i
      title     = result.first["title"]

      [Book.new(id: id, title: title)]
    else
      []
    end
  end

  def copies
    result = DB.exec("SELECT COUNT(*) FROM copies WHERE book_id = #{@id}")
    result.first["count"].to_i
  end

  def create_copies(count)
    count.times do
      DB.exec("INSERT INTO copies (book_id, checked_out) VALUES (#{@id}, 'f');")
    end
  end

  def available_copies
    result = DB.exec("SELECT COUNT(*) FROM copies WHERE book_id = #{@id} AND checked_out='f'")
    result.first["count"].to_i
  end
end
