require './test/test_helper'

class ShelfTest < MiniTest::Test
  include SampleBooks

  def setup
    @shelf = Shelf.new(:M)
    @book_objects = [Wonderland, One_Q84, Underground,
             Poodir, Running, Autumns].map do |book|
      Book.new(book)
    end
  end

  def test_shelve
    assert_equal 0, @shelf.books.length
    @book_objects.each do |book|
      @shelf.shelve(book)
    end
    assert_equal 6, @shelf.books.length
  end
end
