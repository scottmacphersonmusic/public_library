require './test/test_helper'

class BookTest < MiniTest::Test
  include SampleBooks

  def setup
    @book = Book.new(SampleBooks::Mockingbird)
  end

  def test_to_s
    assert_equal "\"To Kill A Mockingbird\"\n" +
                 "Author: Harper Lee\n" +
                 "Status: In\n\n",
                 @book.to_s
  end

  def test_status
    assert_equal "In", @book.status
    @book.available = false
    assert_equal "Out", @book.status
  end

  def test_available?
    assert_equal true, @book.available?
    @book.available = false
    assert_equal false, @book.available?
  end

  def test_toggle_availability
    @book.toggle_availability
    refute @book.available
    @book.toggle_availability
    assert @book.available
  end
end
