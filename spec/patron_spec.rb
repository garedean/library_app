require('spec_helper')

describe(Patron) do
  describe('#id') do
    it("will return an patron's id") do
      patron = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron.save
      expect(patron.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('will return an empty array when no patrons exist') do
      expect(Patron.all()).to(eq([]))
    end

    it('will return an array of patrons when patrons exist') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      patron2 = Patron.new(id: nil, first_name: "Jimmy", last_name: "Dean")
      patron2.save
      expect(Patron.all).to(eq([patron1, patron2]))
    end
  end

  describe('#==') do
    it('will return true when objects are equal in practical terms') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      patron2 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron2.save
      expect(patron1).to(eq(patron2))
    end
  end

  describe('#save') do
    it('will save a book to the database') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      expect(Patron.all).to(eq([patron1]))
    end
  end

  describe('#first_name') do
    it('will return the first name of an patron') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      expect(patron1.first_name).to(eq("George"))
    end
  end

  describe('#last_name') do
    it('will return the last name of an patron') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      expect(patron1.last_name).to(eq("Michael"))
    end
  end

  describe('#full_name') do
    it('will return the full_name name of an patron') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      expect(patron1.full_name).to(eq("George Michael"))
    end
  end

  describe('.find') do
    it('will find a patron from their unique id') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      patron2 = Patron.new(id: nil, first_name: "JK", last_name: "Rowling")
      patron2.save
      expect(Patron.find(id: patron1.id)).to(eq([patron1]))
    end

    it('will find an patron from their first name') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      patron2 = Patron.new(id: nil, first_name: "JK", last_name: "Rowling")
      patron2.save
      expect(Patron.find(first_name: patron1.first_name)).to(eq([patron1]))
    end

    it('will find an patron from their last name') do
      patron1 = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron1.save
      patron2 = Patron.new(id: nil, first_name: "JK", last_name: "Rowling")
      patron2.save
      expect(Patron.find(last_name: patron1.last_name)).to(eq([patron1]))
    end
  end

  describe('#update') do
    it("will update an patron's first_name") do
      patron = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron.save
      patron.update(first_name: "Jimmy")
      expect(patron.first_name).to(eq("Jimmy"))
    end

    it("will update an patron's last_name") do
      patron = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron.save
      patron.update(last_name: "Dean")
      expect(patron.last_name).to(eq("Dean"))
    end
  end

  describe('#checked_out') do
    it('will return an empty array of books checked out to a patron if they have no books checked out') do
      patron = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron.save
      expect(patron.checked_out).to(eq([]))
    end
  end

  describe('#checkout') do
    it('will check out a copy of a book to a patron') do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      patron = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron.save
      patron.checkout([book])
      expect(patron.checked_out).to(eq([book]))
    end
    it('will check out several books to a patron') do
      book1 = Book.new(id: nil, title: "Count of Monte Cristo")
      book1.save
      book2 = Book.new(id: nil, title: "Where the Wild Things Are")
      book2.save
      patron = Patron.new(id: nil, first_name: "George", last_name: "Michael")
      patron.save
      patron.checkout([book1, book2])
      expect(patron.checked_out).to(eq([book1, book2]))
    end
  end


  # describe('#delete') do
  #
  # end
end
