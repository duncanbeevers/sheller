require File.join(File.dirname(__FILE__), 'test_helper')

class ShellerTest < Test::Unit::TestCase
  TEST_DIR = File.join(File.dirname(__FILE__))
  
  def setup
    @original_dir = Dir.pwd
    Dir.chdir(TEST_DIR)
  end
  
  def teardown
    Dir.chdir(@original_dir)
  end
  
  def test_command_no_arguments
    assert_equal "turtle\n", Sheller.execute('./echo_turtle').stdout
  end
  
end
