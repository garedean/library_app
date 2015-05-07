require('spec_helper')

describe(Author) do
  describe('#id') do
    it("will return an author's id") do
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      expect(author.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('will return an empty array when no authors exist') do
      expect(Author.all()).to(eq([]))
    end

    it('will return an array of books when books exist') do
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      author2 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author2.save
      expect(Author.all).to(eq([author1, author2]))
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

  describe('#update') do
    it("will update an author's first_name") do
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      author.update(first_name: "Jimmy")
      expect(author.first_name).to(eq("Jimmy"))
    end

    it("will update an author's last_name") do
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      author.update(last_name: "Dean")
      expect(author.last_name).to(eq("Dean"))
    end
  end

  describe('#books') do
    it('will return an empty array when author has no books') do
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      expect(author.books).to(eq([]))
    end

    it('will return and array of the books for a given author') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are")
      book2.save
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      book1.add_author([author1])
      book2.add_author([author1])
      expect(author1.books).to(eq([book1, book2]))
    end
  end

  # describe('#delete') do
  #   it('will delete a book from the database') do
  #     book1 = Book.new(id: nil, title: "Count of Monte Cristo", author_id: 1)
  #     book1.save
  #     book1.delete
  #     expect(Book.all).to(eq([]))
  #   end
  # end
end
