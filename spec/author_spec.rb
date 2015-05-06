require('spec_helper')

describe(Author) do
  describe('.all') do
    it('will return an empty array when no authors exist') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('will return true when objects are equal in practical terms') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      author2 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author2.save
      expect(author1).to(eq(author2))
    end
  end

  describe('#save') do
    it('will save a book to the database') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      expect(Author.all).to(eq([author1]))
    end
  end

  describe('#first_name') do
    it('will return the first name of an author') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      expect(author1.first_name).to(eq("Alexander"))
    end
  end

  describe('#last_name') do
    it('will return the last name of an author') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      expect(author1.last_name).to(eq("Dumas"))
    end
  end

  describe('#full_name') do
    it('will return the full_name name of an author') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      expect(author1.full_name).to(eq("Alexander Dumas"))
    end
  end

  describe('.find') do
    it('will find a author from their unique id') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      author2 = Author.new(id: nil, first_name: "JK", last_name: "Rowling")
      author2.save
      expect(Author.find(id: author1.id)).to(eq([author1]))
    end

    it('will find an author from their first name') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      author2 = Author.new(id: nil, first_name: "JK", last_name: "Rowling")
      author2.save
      expect(Author.find(first_name: author1.first_name)).to(eq([author1]))
    end

    it('will find an author from their last name') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      author2 = Author.new(id: nil, first_name: "JK", last_name: "Rowling")
      author2.save
      expect(Author.find(last_name: author1.last_name)).to(eq([author1]))
    end
  end
  #
  # describe('#update') do
  #   it("will update a book's title") do
  #     book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
  #     book1.save
  #     book1.update(title: "Count of Monte Cristo V2")
  #     expect(book1.title).to(eq("Count of Monte Cristo V2"))
  #   end
  #
  #   it("will update a book's author") do
  #     book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
  #     book1.save
  #     book1.update(author_id: 2)
  #     expect(book1.author_id).to(eq(2))
  #   end
  # end
  #
  # describe('#delete') do
  #   it('will delete a book from the database') do
  #     book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
  #     book1.save
  #     book1.delete
  #     expect(Book.all).to(eq([]))
  #   end
  # end
end
