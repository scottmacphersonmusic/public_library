require './test/test_helper'

class ShelfTest < MiniTest::Test
  def setup
    @shelf_1 = Shelf.new(:M)
    @book_objects = [Wonderland, One_Q84, Underground,
                     Poodir, Running, Autumns].map do |book|
      Book.new(book)
    end
    @shelf_2 = Shelf.new(:M)
    @shelf_2.books = @book_objects
  end

  def test_add
    assert_equal 0, @shelf_1.books.length
    @book_objects.each do |book|
      @shelf_1.add(book)
    end
    assert_equal 6, @shelf_1.books.length
  end

  def test_remove_book_that_is_present
    assert_equal 6, @shelf_2.books.length
    title = "1Q84"
    book = @shelf_2.remove(title)
    # make sure book is no longer in shelf
    assert_equal 5, @shelf_2.books.length
    assert_equal 0, @shelf_2.books.count { |b| b.title == title }
    # make sure remove returns book object
    assert_equal title, book.title
  end
end
