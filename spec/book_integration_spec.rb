require('capybara/rspec')
require('./app')
require('spec_helper')
set(:show_exceptions, false)

Capybara.app = Sinatra::Application

# describe("the libary app", :type => :feature) do
#   describe("add a book page") do
#     it('will allow a user to add a book to the catalog') do
#       visit('/books/new')
#       fill_in('title', with: "The Count of Monte Cristo")
#       fill_in('first_name', with: "Alexander")
#       fill_in('last_name', with: "Dumas")
#       click_on('Add')
#       expect(page).to(have_content("The Count of Monte Cristo by Alexander Dumas"))
#     end
#   end
#
#   describe("lookup a book page") do
#     it("returns books that match the search string") do
#       visit('/books/new')
#       fill_in('title', with: "The Count of Monte Cristo")
#       fill_in('first_name', with: "Alexander")
#       fill_in('last_name', with: "Dumas")
#       click_on('Add')
#       fill_in('title', with: "The Count of Monte Cristo")
#       click_button('Search!')
#       expect(page).to(have_content("The Count of Monte Cristo"))
#     end
#   end
# end
