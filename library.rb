class Library
  attr_accessor :books, :shelves

  def initialize(books)
    @books   ||= generate_books(books)
    @shelves ||= generate_shelves
  end

  def directory
    sorted_books = @books.sort_by do |book|
      [book.author["last_name"], book.title]
    end
    sorted_books.each { |book| puts book }
  end

  private

  def generate_books(books)
    books.map { |book_hash| Book.new(book_hash) }
  end

  def generate_shelves
    shelves = Hash.new { |hash, key| hash[key] = Shelf.new(key) }
    ("A".."Z").to_a.map do |name|
      shelves[name.to_sym]
    end
    shelves
  end

end

class Shelf
  attr_accessor :name, :books

  def initialize(name)
    @name = name
    @books = []
  end
end

class Book
  attr_reader :title, :author, :genre

  def initialize(attr = {})
    @title     = attr[:title]
    @author    = attr[:author]
    @genre     = attr[:genre]
  end

  def to_s
    "\"#{@title}\" by #{@author['first_name']} #{@author['last_name']}"
  end
end
