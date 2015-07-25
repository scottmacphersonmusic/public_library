require './test/test_helper'

class BookTest < MiniTest::Test
  include SampleBooks

  def setup
    @book = Book.new(SampleBooks::Mockingbird)
  end

  def test_to_s
    assert_equal "\"To Kill A Mockingbird\"\nAuthor: Harper Lee\nStatus: In\n\n",
                 @book.to_s
  end
end
