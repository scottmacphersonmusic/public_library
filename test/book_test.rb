require './test/test_helper'

class BookTest < MiniTest::Test
  include SampleBooks

  def test_book
    assert Book.new
  end
end
