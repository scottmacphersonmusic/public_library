require './test/test_helper'

class IntegrationTest < MiniTest::Test
  include SampleBooks

  def setup
    @lib = Library.new(SampleBooks::Lib)
    @shelf = @lib.shelves[:M]
    @book = @shelf.books.find do |book|
      book.title == "Hard-Boiled Wonderland and the End of the World"
    end
  end

  def test_books_are_shelved_upon_initialization
    assert_equal 6, @lib.shelves[:M].books.length
    assert_equal 1, @lib.shelves[:E].books.length
  end
end
