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
      puts "#{removed_book.title} has been checked out."
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
      puts "#{book.title} has been returned."
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
    %Q|"#{@title}"\nAuthor: #{@author['first_name']} | \
      "#{@author['last_name']}\nStatus: #{status}\n\n"
  end

  def status
    if @available
      "In"
    else
      "Out"
    end
  end
end

#  Usage  # # # # # # # # # # # # # # # # # # # # # # # # # #

# First we'll gather some books to donate to the library:

Mockingbird = { title: "To Kill A Mockingbird",
                author: { "first_name" => "Harper",
                          "last_name" => "Lee"},
                genre: "Fiction" }

Wonderland = { title: "Hard-Boiled Wonderland and the End of the World",
               author: { "first_name" => "Haruki",
                         "last_name" => "Murakami"},
               genre: "Fiction" }

One_Q84 = { title: "1Q84",
            author: { "first_name" => "Haruki",
                      "last_name" => "Murakami"},
            genre: "Fiction" }

Steel = { title: "Guns, Germs and Steel",
          author: { "first_name" => "Jared",
                    "last_name" => "Diamond"},
          genre: "History" }

Underground = { title: "Underground: The Tokyo Gas Attack and the Japanese Pysche",
                author: { "first_name" => "Haruki",
                          "last_name" => "Murakami" },
                genre: "Non-Fiction" }


Poodir = { title: "Practical Object-Oriented Design In Ruby",
           author: { "first_name" => "Sandi",
                     "last_name" => "Metz" },
           genre: "Programming" }

BriefHistory = { title: "A Brief History Of Time",
                 author: { "first_name" => "Stephen",
                           "last_name" => "Hawking" },
                 genre: "Popular Science" }

WhatWhat = { title: "What Is The What",
             author: { "first_name" => "Dave",
                       "last_name" => "Eggars" },
             genre: "Memoir" }

Running = { title: "What I Talk About When I Talk About Running",
            author: { "first_name" => "Haruki",
                      "last_name" => "Murakami" },
            genre: "Memoir" }

Autumns = { title: "The Thousand Autumns of Jacob de Zoet: A novel",
            author: { "first_name" => "David",
                      "last_name" => "Mitchell" },
            genre: "Fiction" }

Lib = [Mockingbird, Wonderland, One_Q84, Steel,
       Underground, Poodir, BriefHistory, WhatWhat, Running, Autumns]

# Now initialize a new instance of Library using the above books:

# lib = Library.new(Lib)

# Browse books using the directory:

# lib.directory

# Checkout some books:

# lib.checkout "Practical Object-Oriented Design In Ruby"

# lib.checkout "1Q84"

# Browsing the directory at this time will show these books are checked-out.

# Having read some books, return them:

# lib.return "1Q84"

# lib.return "Practical Object-Oriented Design In Ruby"
