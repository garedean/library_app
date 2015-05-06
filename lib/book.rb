class Book
  def intitialize(attributes)

  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books")
    books = []
    returned_books.each do |book|
      title   = book["title"]
      book_id = book["author_id"].to_i
      books << Book.new(title: title, book_id: book_id)
    end
    books
  end
end
