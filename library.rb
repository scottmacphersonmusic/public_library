class Library
  attr_accessor :shelves, :checked_out

  def initialize(book_hashes)
    @shelves ||= generate_shelves
    stock_shelves(book_hashes)

    @checked_out = []
  end

  def directory
    all_books = collect_books
    sorted_books = all_books.sort_by do |book|
      [book.author["last_name"], book.title]
    end
    sorted_books.each { |book| puts book }
  end

  def checkout(book_title)
    book = collect_books.find { |b| b.title == book_title }
    if book.available
      shelf = book.author['last_name'][0].to_sym
      removed_book = @shelves[shelf].remove(book.title)
      removed_book.available = false
      @checked_out << removed_book
    else
      puts "That book is currently checked out."
    end
  end

  def return(book_title)
    index = @checked_out.index { |book| book.title == book_title }
    if index
      book = @checked_out.delete_at(index)
      book.available = true
      shelve([book])
    else
      puts "Oops! That book doesn't belong to this library."
    end
  end

  private

  def generate_shelves
    shelves = Hash.new { |hash, key| hash[key] = Shelf.new(key) }
    ("A".."Z").to_a.map do |name|
      shelves[name.to_sym]
    end
    shelves
  end

  def generate_books(book_hashes)
    book_hashes.map { |book_hash| Book.new(book_hash) }
  end

  def shelve(book_objects)
    book_objects.map do |book|
      shelf = @shelves[(book.author["last_name"][0]).to_sym]
      shelf.add(book)
    end
  end

  def stock_shelves(book_hashes)
    books = generate_books(book_hashes)
    shelve(books)
  end

  def collect_books
    all_books = []
    @shelves.values.each do |shelf|
      shelf.books.each do |book|
        all_books << book
      end
    end
    @checked_out.each { |book| all_books << book }
    all_books
  end
end

class Shelf
  attr_accessor :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add(book)
    @books << book
  end

  def remove(book_title)
    index = @books.index { |b| b.title == book_title }
    if index
      return @books.delete_at(index)
    end
  end
end

class Book
  attr_reader :title, :author, :genre
  attr_accessor :available

  def initialize(attr = {})
    @title     = attr[:title]
    @author    = attr[:author]
    @genre     = attr[:genre]
    @available = true
  end

  def to_s
    "\"#{@title}\"\n" +
      "Author: #{@author['first_name']} " +
      "#{@author['last_name']}\n" +
      "Status: #{status}\n\n"
  end

  def status
    if @available
      "In"
    else
      "Out"
    end
  end
end
