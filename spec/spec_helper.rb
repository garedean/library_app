require('rspec')
require('book')
require('pg')

DB = PG.connect(dbname: 'library_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books;")
  end
end
