require './test/test_helper'

class BookTest < MiniTest::Test
  def test_book
    assert Book.new
  end
end
