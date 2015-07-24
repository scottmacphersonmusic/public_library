require './test/test_helper'

class LibraryTest < MiniTest::Test
  include SampleBooks

  def setup
    @lib = Library.new(Lib)
  end

  def test_library_books_is_an_array_of_book_objects
    assert_instance_of Array, @lib.books
    @lib.books.each do |item|
      assert_instance_of Book, item
    end
  end
end
