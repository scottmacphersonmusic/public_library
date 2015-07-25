require './test/test_helper'

class ShelfTest < MiniTest::Test
  include SampleBooks

  def test_shelf
    assert Shelf.new("A")
  end
end
