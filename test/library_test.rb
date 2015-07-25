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

  def test_directory_prints_alphabetically_by_author_last_name
    assert_output(/\A"Guns, Germs and Steel" by Jared Diamond/) { @lib.directory }
    assert_output(/Talk About Running" by Haruki Murakami\n\z/) { @lib.directory }
  end

  def test_library_shelves_is_a_hash_of_shelf_objects
    assert_instance_of Hash, @lib.shelves
    @lib.shelves.each_value do |value|
      assert_instance_of Shelf, value
    end
  end

  def test_books_are_shelved_upon_initialization
    assert_equal 6, @lib.shelves[:M].books.length
    assert_equal 1, @lib.shelves[:E].books.length
  end
end
