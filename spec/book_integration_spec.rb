require('capybara/rspec')
require('./app')
require('spec_helper')
set(:show_exceptions, false)

Capybara.app = Sinatra::Application

describe("the libary app", :type => :feature) do
  describe("add a book page") do
    it('will allow a user to add a book with a single author the catalog') do
      visit('/books/new')
      fill_in('title', with: "The Count of Monte Cristo")
      fill_in('first_name1', with: "Alexander")
      fill_in('last_name1', with: "Dumas")
      click_on('Add')
      expect(page).to(have_content("The Count of Monte Cristo by Alexander Dumas"))
      expect(page).not_to(have_content("The Count of Monte Cristo by Alexander Dumas and"))
    end

    it('will allow a user to add a book with multiple authors to the catalog') do
      visit('/books/new')
      fill_in('title', with: "The Count of Monte Cristo")
      fill_in('first_name1', with: "Alexander")
      fill_in('last_name1', with: "Dumas")
      fill_in('first_name2', with: "Kimmy")
      fill_in('last_name2', with: "Dean")
      click_on('Add')
      expect(page).to(have_content("The Count of Monte Cristo by Alexander Dumas and Kimmy Dean"))
    end
  end

  describe("lookup a book page") do
    it("returns books that match the search string") do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      book.add_author([author])

      visit('/books/lookup')
      fill_in('title', with: "Count of Monte Cristo")
      click_button('Search!')
      expect(page).to(have_content("Count of Monte Cristo"))
    end
  end

  describe('the book details page') do
    it('allows a books title to be update') do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      book.add_author([author])

      visit("/books/#{book.id}")
      fill_in("title", with: "New Book Title")
      click_button("Update")
      expect(page).to(have_content("New Book Title"))
    end

    it("allows a book's first author to be updated") do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      author = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author.save
      book.add_author([author])

      visit("/books/#{book.id}")
      fill_in("first_name1", with: "First1")
      fill_in("last_name1", with: "Last1")
      click_button("Update")
      expect(page).to(have_content("by First1 Last1"))
    end

    it("allows a book's second author to be update") do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      author2 = Author.new(id: nil, first_name: "Jimmy", last_name: "Dean")
      author2.save
      book.add_author([author1, author2])

      visit("/books/#{book.id}")
      fill_in("first_name2", with: "First2")
      fill_in("last_name2", with: "Last2")
      click_button("Update")
      expect(page).to(have_content("and First2 Last2"))
    end

    it('allows a book to be deleted') do
      book = Book.new(id: nil, title: "Count of Monte Cristo")
      book.save
      author1 = Author.new(id: nil, first_name: "Alexander", last_name: "Dumas")
      author1.save
      book.add_author([author1])

      visit("/books/#{book.id}")
      click_button("Delete")
      expect(page).to(have_content("The library is currently empty."))
    end
  end
end
