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
  
  def test_command_one_argument
    assert_equal "frog\n", Sheller.execute('echo', 'frog').stdout
  end
  
  def test_command_one_argument_with_quotes
    assert_equal "\"toad\"\n", Sheller.execute('echo', '"toad"').stdout
  end
  
  def test_command_one_argument_with_redirect
    assert_equal "toad > newt\n", Sheller.execute('echo', 'toad > newt').stdout
  end
  
end
