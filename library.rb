class Library
  attr_accessor :shelves, :checked_out

  def initialize(book_hashes)
    @shelves = generate_shelves
    @catalog = {}
    stock_shelves(book_hashes)

    @checked_out = []
  end

  def add_new_book(book)
    return puts "We already have this book." if @catalog[book.title]
    @catalog[book.title] = book.author['last_name']
    shelve(book)
  end

  def directory
    sorted_books = collect_books.sort_by do |book|
      [book.author["last_name"], book.title]
    end
    puts sorted_books
  end

  def checkout(book_title)
    return puts "Sorry, we don't have that book." unless @catalog[book_title]
    book = shelf_for_title(book_title).get_book(book_title)
    if book
      shelf = book.author['last_name'][0].to_sym
      removed_book = @shelves[shelf].remove(book.title)
      removed_book.toggle_availability
      @checked_out << removed_book
      puts %Q|"#{removed_book.title}" has been checked out.|
    else
      puts "That book is currently checked out."
    end
  end

  def return(book_title)
    index = @checked_out.index { |book| book.title == book_title }
    if index
      book = @checked_out.delete_at(index)
      book.toggle_availability
      shelve(book)
      puts %Q|"#{book.title}" has been returned.|
    else
      puts "Oops! That book doesn't belong to this library."
    end
  end

  private

  def shelf_for_title(book_title)
    author_last_name = @catalog[book_title]
    @shelves[author_last_name[0].to_sym]
  end

  def generate_shelves
    shelves = Hash.new { |hash, key| hash[key] = Shelf.new(key) }
    ("A".."Z").to_a.each { |name| shelves[name.to_sym] }
    shelves
  end

  def generate_books(book_hashes)
    book_hashes.map { |book_hash| Book.new(book_hash) }
  end

  def shelve(book)
    shelf = @shelves[(book.author["last_name"][0]).to_sym]
    shelf.add(book)
  end

  def stock_shelves(book_hashes)
    books = generate_books(book_hashes)
    books.each { |book| add_new_book(book) }
  end

  def collect_books
    @shelves.values.map(&:books).flatten + @checked_out
  end
end

class Shelf
  attr_reader :name

  def initialize(name)
    @name = name
    @books = {}
  end

  def books
    @books.values
  end

  def get_book(book_title)
    @books[book_title]
  end

  def add(book)
    @books[book.title] = book
  end

  def remove(book_title)
    @books.delete(book_title)
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
    @available ? "In" : "Out"
  end

  def available?
    @available ? true : false
  end

  def toggle_availability
    @available ? @available = false : @available = true
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

lib = Library.new(Lib)

# Browse books using the directory:

# lib.directory

# Donate another book to the library:

# lib.add_new_book(Book.new({ title: "Between The World And Me",
#                             author: { "first_name" => "Ta-Nehisi",
#                                       "last_name" => "Coates" },
#                             genre: "Non-Fiction" }))

# Checkout some books:

# lib.checkout "Between The World And Me"

# lib.checkout "Practical Object-Oriented Design In Ruby"

# lib.checkout "1Q84"

# Browsing the directory at this time will show these books are checked-out.

# Having read some books, return them:

# lib.return "1Q84"

# lib.return "Practical Object-Oriented Design In Ruby"

# One issue with the above approach is that it is only possible to have one copy of each book.  An improvement would be to track the books with IDs instead of by title so that there could be multiple copies.
