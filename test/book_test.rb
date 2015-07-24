require './test/test_helper'

class BookTest < MiniTest::Test
  include SampleBooks

  def test_to_s
    mockingbird = Book.new(SampleBooks::Mockingbird)
    assert_equal '"To Kill A Mockingbird" by Harper Lee',
                 mockingbird.to_s
  end
end
