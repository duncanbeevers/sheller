require File.join(File.dirname(__FILE__), 'test_helper')

class ShellerTest < Test::Unit::TestCase
  TEST_DIR = File.join(File.dirname(__FILE__))
  
  def test_command_no_arguments
    Dir.chdir(TEST_DIR) do
      assert_equal "turtle\n", Sheller.execute('./echo_turtle')
    end
  end
end
