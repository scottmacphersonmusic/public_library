class Library
  attr_reader :books

  def initialize(books)
    @books = books.map { |book_hash| Book.new(book_hash)}
  end

  def directory
    sorted_books = @books.sort_by do |book|
      [book.author["last_name"], book.title]
    end
    sorted_books.each { |book| puts book }
  end
end

class Shelf
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
