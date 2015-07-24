require './test/test_helper'

class LibraryTest < MiniTest::Test
  include SampleBooks

  def test_library
    lib = Library.new(Lib)
    assert_instance_of Array, lib.books
  end
end
