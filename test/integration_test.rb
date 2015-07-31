require './test/test_helper'

class IntegrationTest < MiniTest::Test
  include SampleBooks

  def setup
    @lib = Library.new(SampleBooks::Lib)
    @shelf = @lib.shelves[:M]
    @book = @shelf.books.find do |book|
      book.title == "Hard-Boiled Wonderland and the End of the World"
    end

    @lib_2 = Library.new(SampleBooks::Lib)
    @lib_2.checkout(@book.title)
  end

  def test_books_are_shelved_upon_initialization
    assert_equal 6, @lib.shelves[:M].books.length
    assert_equal 1, @lib.shelves[:E].books.length
  end

  def test_checkout_updates_availability_status
    @lib.checkout(@book.title)
    assert_equal "Out", @book.status
  end

  def test_checkout_moves_book_to_checked_out
    @lib.checkout(@book.title)
    assert_equal "Hard-Boiled Wonderland and the End of the World",
                 @lib.checked_out[0].title
  end

  def test_checkout_with_invalid_title_returns_message
    assert_output("Sorry, we don't have that book.\n") do
      @lib.checkout("Fifty Shades of Grey")
    end
  end

  def test_return_reshelves_book
    @lib_2.return(@book.title)
    assert_equal 0, @lib.checked_out.length
    assert @lib_2.shelves[:M].books.index { |b| b.title == @book.title }
  end

  def test_return_updates_availability_status
    @lib_2.return(@book.title)
    shelf = @lib_2.shelves[:M]
    index = shelf.books.index do |book|
      book.title == @book.title
    end
    assert shelf.books[index].available
  end

  def test_return_invalid_book_title_returns_message
    assert_output("Oops! That book doesn't belong to this library.\n") do
      @lib_2.return("Fifty Shades of Grey")
    end
  end
end
