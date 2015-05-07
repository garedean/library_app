require('pry')

class Author
  attr_reader(:id, :first_name, :last_name)

  def initialize(attributes)
    @id         = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name  = attributes[:last_name]
  end

  def ==(other_author)
    first_name.==(other_author.first_name) && last_name.==(other_author.last_name)
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def save
    result = DB.exec("INSERT INTO authors (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first['id']
  end

  def self.clear
    DB.exec("DELETE FROM authors;")
  end

  def self.all
    authors = []
    returned_authors = DB.exec("SELECT * FROM authors;")
    returned_authors.each do |author|
      id = author['id'].to_i
      first_name = author['first_name']
      last_name = author['last_name']
      authors << Author.new(id: id, first_name: first_name, last_name: last_name)
    end
    authors
  end

  def self.find(attributes)
    id         = attributes.fetch(:id, nil)
    full_name  = attributes.fetch(:full_name, nil)
    first_name = attributes.fetch(:first_name, nil)
    last_name  = attributes.fetch(:last_name, nil)

    returned_authors = if id
      DB.exec("SELECT * FROM authors WHERE id = #{id.to_i};")
    elsif first_name && last_name
      DB.exec("SELECT * FROM authors WHERE first_name = '#{first_name}' AND last_name='#{last_name}';")
    elsif first_name
      DB.exec("SELECT * FROM authors WHERE first_name = '#{first_name}';")
    elsif last_name
      DB.exec("SELECT * FROM authors WHERE last_name = '#{last_name}';")
    end

    authors = []

    returned_authors.each do |author|
      id         = author["id"].to_i
      first_name = author["first_name"]
      last_name  = author["last_name"]
      authors << Author.new(id: id, first_name: first_name, last_name: last_name)
    end
    authors
  end
end
