require('spec_helper')

describe(Book) do
  describe('.all') do
    it('will return an empty array of books to start') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('will return true when objects are equal in practical terms') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book2 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      expect(book1).to(eq(book2))
    end
  end

  describe('#save') do
    it('will save a book to the database') do
      book = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book.save
      expect(Book.all).to(eq([book]))
    end
  end

  describe('#title') do
    it('will return the title of a book') do
      book = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book.save
      expect(book.title).to(eq("Count of Monte Cristo"))
    end
  end

  describe('#author_id') do
    it('will return the author_id of a book') do
      book = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book.save
      expect(book.author_id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.find') do
    it('will find a book from its unique id') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are", author_id: 2)
      book2.save
      expect(Book.find(id: book1.id)).to(eq([book1]))
    end

    it('will find a book from its title') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are", author_id: 2)
      book2.save
      expect(Book.find(title: book1.title)).to(eq([book1]))
    end

    it('will find a book from its author_id') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are", author_id: 2)
      book2.save
      expect(Book.find(author_id: book1.author_id)).to(eq([book1]))
    end
  end

  describe('#update') do
    it("will update a book's title") do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book1.save
      book1.update(title: "Count of Monte Cristo V2")
      expect(book1.title).to(eq("Count of Monte Cristo V2"))
    end

    it("will update a book's author") do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book1.save
      book1.update(author_id: 2)
      expect(book1.author_id).to(eq(2))
    end
  end

  describe('#delete') do
    it('will delete a book from the database') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
      book1.save
      book1.delete
      expect(Book.all).to(eq([]))
    end
  end
end
