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
end
