require('spec_helper')

describe(Book) do
  describe('.all') do
    it('will return an empty array of books to start') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('will return true when objects are equal in practical terms') do
      book1 = Book.new(title: "Count of Monte Cristo")
      book2 = Book.new(title: "Count of Monte Cristo")
      expect(book1).to(eq(book2))
    end
  end

  describe('#save') do
    it('will save a book to the database') do
      book = Book.new(title: "Count of Monte Cristo")
      book.save
      expect(Book.all).to(eq([book]))
    end
  end

  describe('#title') do
    it('will return the title of a book') do
      book = Book.new(title: "Count of Monte Cristo")
      book.save
      expect(book.title).to(eq("Count of Monte Cristo"))
    end
  end
end
