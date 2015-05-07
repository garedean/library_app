class Patron
  attr_reader(:id, :first_name, :last_name, :full_name)

  def initialize(attributes)
    @id         = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name  = attributes[:last_name]
    @full_name  = "#{@first_name} #{@last_name}"
  end

  def ==(other_patron)
    first_name.==(other_patron.first_name) && last_name.==(other_patron.last_name)
  end

  def save
    result = DB.exec("INSERT INTO patrons (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.clear
    DB.exec("DELETE FROM patrons;")
  end

  def self.all
    patrons = []
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    returned_patrons.each do |patron|
      id = patron['id'].to_i
      first_name = patron['first_name']
      last_name = patron['last_name']
      patrons << Author.new(id: id, first_name: first_name, last_name: last_name)
    end
    patrons
  end

  def self.find(attributes)
    id         = attributes.fetch(:id, nil)
    full_name  = attributes.fetch(:full_name, nil)
    first_name = attributes.fetch(:first_name, nil)
    last_name  = attributes.fetch(:last_name, nil)

    returned_patrons = if id
      DB.exec("SELECT * FROM patrons WHERE id = #{id.to_i};")
    elsif first_name && last_name
      DB.exec("SELECT * FROM patrons WHERE first_name = '#{first_name}' AND last_name='#{last_name}';")
    elsif first_name
      DB.exec("SELECT * FROM patrons WHERE first_name = '#{first_name}';")
    elsif last_name
      DB.exec("SELECT * FROM patrons WHERE last_name = '#{last_name}';")
    end

    patrons = []

    returned_patrons.each do |patron|
      id         = patron["id"].to_i
      first_name = patron["first_name"]
      last_name  = patron["last_name"]
      patrons << Author.new(id: id, first_name: first_name, last_name: last_name)
    end
    patrons
  end

  def update(options)
    first_name = options.fetch(:first_name, nil)
    last_name  = options.fetch(:last_name, nil)

    if first_name
      DB.exec("UPDATE patrons SET first_name = '#{first_name}' WHERE id = #{@id};")
      @first_name = first_name
    end
    if last_name
      DB.exec("UPDATE patrons SET last_name = '#{last_name}' WHERE id = #{@id};")
      @last_name = last_name
    end
  end

  def checked_out
    returned_book_ids = DB.exec("SELECT book_id FROM copies WHERE patron_id = #{@id};")
    checked_out_books = []

    returned_book_ids.each do |id|
      id = id["book_id"].to_i
      checked_out_books << Book.find(id: id).first
    end
    checked_out_books
  end

  def checkout(books)
    time     = Time.now
    due_date = time + (2*7*24*60*60)

    books.each do |book|
      available_copies = DB.exec("SELECT id FROM copies WHERE checked_out='f' AND book_id=#{book.id};")
      DB.exec("UPDATE copies SET checked_out='t', patron_id=#{@id}, due_date='#{due_date}' WHERE id=#{available_copies.first["id"].to_i};")
    end
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
    DB.exec("UPDATE copies SET checked_out='f', patron_id='null', due_date='null' WHERE patron_id=#{@id};")
  end
end
