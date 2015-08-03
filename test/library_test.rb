require './test/test_helper'

class LibraryTest < MiniTest::Test
  def setup
    @lib = Library.new(SampleBooks::Lib)

    @lib_2 = Library.new(SampleBooks::Lib)
    harry_potter = Book.new({ title: "Harry Potter and the Sorcerer's Stone",
                              author: {"first_name" => "J.K.",
                                       "last_name" => "Rowling"},
                              genre: "Fantasy" })

    @lib_2.add_new_book(harry_potter)
    @lib_2.checkout(harry_potter.title)
  end

  def test_library_shelves_is_a_hash_of_shelf_objects
    assert_instance_of Hash, @lib.shelves
    shelves = @lib.shelves.values
    assert shelves.all? { |obj| obj.class == Shelf }
  end

  def test_directory_prints_alphabetically_by_author_last_name
    start = /\A"Guns, Germs and Steel"\nAuthor: Jared Diamond\nStatus: In\n/
    assert_output(start) { @lib.directory }
    finish = /Talk About Running"\nAuthor: Haruki Murakami\nStatus: In\n\n\z/
    assert_output(finish) { @lib.directory }
  end

  def test_directory_collects_books_from_checked_out
    assert_output(/Author: J.K. Rowling\nStatus: Out\n\n\z/) do
      @lib_2.directory
    end
  end

  def test_checkout_on_book_with_out_status_returns_message
    assert_output("That book is currently checked out.\n") do
      @lib_2.checkout("Harry Potter and the Sorcerer's Stone")
    end
  end

  def test_return_prints_message_if_book_title_not_recognized
    assert_output("Oops! That book doesn't belong to this library.\n") do
      @lib.return("")
    end
  end
end
