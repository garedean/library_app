require('pry')

class Book
  attr_reader(:id, :title, :author_id)

  def initialize(attributes)
    @title     = attributes[:title]
    @author_id = attributes[:author_id]
    @id        = attributes[:id]
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |book|
      title   = book["title"]
      author_id = book["author_id"].to_i
      books << Book.new(id: nil, title: title, author_id: author_id)
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@title}', #{@author_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(other_book)
    title.==(other_book.title) && author_id.==(other_book.author_id)
  end

  def self.find(target_id)
    result = DB.exec("SELECT * FROM books WHERE id = #{target_id}")
    id        = result.first["id"].to_i
    title     = result.first["title"]
    author_id = result.first["author_id"].to_i

    Book.new(id: id, title: title, author_id: author_id)
  end

  def update(attributes)
    @title     = attributes.fetch(:title, @title)
    @author_id = attributes.fetch(:author_id, @author_id)
    DB.exec("UPDATE books SET title = '#{title}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET author_id = #{author_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end
end
