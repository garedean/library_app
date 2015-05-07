require('spec_helper')

describe(Book) do
  describe('#id') do
    it("will return a book's id") do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save

      expect(book.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('will return an empty array of books to start') do
      expect(Book.all()).to(eq([]))
    end

    it('will return an array of books when books exist') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are")
      book2.save
      expect(Book.all).to(eq([book1, book2]))
    end
  end

  describe('#==') do
    it('will return true when objects are equal in practical terms') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book2 = Book.new(id: nil, title: "Count of Monte Cristo")
      expect(book1).to(eq(book2))
    end
  end

  describe('#save') do
    it('will save a book to the database') do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      expect(Book.all).to(eq([book]))
    end
  end

  describe('#title') do
    it('will return the title of a book') do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      expect(book.title).to(eq("Count of Monte Cristo"))
    end
  end

  describe('#add_author') do
    it('will add an author to a book') do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      book.add_author([author])
      expect(book.authors).to(eq([author]))
    end
  end

  describe('#authors') do
    it('will return the authors of a book') do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      author2 = Author.new(id: nil, first_name: "JK", last_name: "Rowling")
      author2.save
      book.add_author([author1, author2])
      expect(book.authors).to(eq([author1, author2]))
    end
  end

  describe('.find') do
    it('will find a book from its unique id') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are")
      book2.save
      expect(Book.find(id: book1.id)).to(eq([book1]))
    end

    it('will find a book from its title') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are")
      book2.save
      expect(Book.find(title: book1.title)).to(eq([book1]))
    end
  end

  describe('#update') do
    it("will update a book's title") do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      book1.update(title: "Count of Monte Cristo V2")
      expect(book1.title).to(eq("Count of Monte Cristo V2"))
    end

    it("will update a book's author") do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      book1.add_author([author1])
      author2 = Author.new(id: nil, first_name: "JK", last_name: "Rowling")
      author2.save
      book1.update(authors: [author2])
      expect(book1.authors).to(eq([author2]))
    end
  end

  describe('#delete') do
    it('will delete a book from the database') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      book1.add_author([author1])
      book1.delete
      expect(Book.all).to(eq([]))
      expect(book1.authors).to(eq([]))
    end
  end

  describe('.clear') do
    it('will delete all books in the database') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      book1.add_author([author1])
      Book.clear
      expect(Book.all).to(eq([]))
      expect(book1.authors).to(eq([]))
    end
  end
end
