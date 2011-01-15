require File.join(File.dirname(__FILE__), 'test_helper')

class ShellerTest < Test::Unit::TestCase
  TEST_DIR = File.expand_path(File.join(File.dirname(__FILE__)))
  
  def setup
    @original_dir = Dir.pwd
    Dir.chdir(TEST_DIR)
  end
  
  def teardown
    Dir.chdir(TEST_DIR) do
      FileUtils.rm('output.txt', :force => true)
    end
    Dir.chdir(@original_dir)
  end
  
  def test_quote
    assert_equal "'echo'", Sheller.quote("echo")
  end
  
  def test_quote_redirect
    assert_equal ">", Sheller.quote(:>)
  end
  
  def test_quote_named_redirect
    assert_equal ">", Sheller.quote(Sheller::STDOUT_TO_FILE)
  end
  
  def test_command_no_arguments
    assert_equal "turtle\n", Sheller.execute('./fixtures/stdout_turtle').stdout
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
  
  def test_echo_to_stderr
    assert_equal "frog\n", Sheller.execute('./fixtures/stderr_frog').stderr
  end
  
  def test_successful_exit_status_code
    assert_equal 0, Sheller.execute('echo').exit_status
  end
  
  def test_unsuccessful_exit_status_code
    assert_not_equal 0, Sheller.execute('false').exit_status
  end
  
  def test_stdout_to_file
    result = Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDOUT_TO_FILE, 'output.txt')
    assert_equal "puma1\n", File.read('output.txt')
  end
  
  def test_stdout_to_pipe
    result = Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDOUT_TO_PIPE, 'grep', 'puma')
    assert_equal "puma1\n", result.stdout
  end
  
  def test_stdout_append_to_file
    File.open('output.txt', 'w') { |f| f.puts "jungle" }
    Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDOUT_APPEND_TO_FILE, 'output.txt')
    assert_equal "jungle\npuma1\n", File.read('output.txt')
  end
  
  def test_stdout_to_stderr
    result = Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDOUT_TO_STDERR)
    assert_equal "puma2\npuma1\n", result.stderr
  end
  
  def test_stderr_to_file
    Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDERR_TO_FILE, 'output.txt')
    assert_equal "puma2\n", File.read('output.txt')
  end
  
  def test_stderr_to_stdout
    result = Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDERR_TO_STDOUT)
    assert_equal "puma2\npuma1\n", result.stdout
  end
  
  def test_stderr_append_to_file
    File.open('output.txt', 'w') { |f| f.puts "jungle" }
    Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDERR_APPEND_TO_FILE, 'output.txt')
    assert_equal "jungle\npuma2\n", File.read('output.txt')
  end
  
  def test_stdout_and_stderr_to_file
    Sheller.execute('./fixtures/stdout_stderr_puma', Sheller::STDOUT_AND_STDERR_TO_FILE, 'output.txt')
    assert_equal "puma2\npuma1\n", File.read('output.txt')
  end
  
  def test_stdin_from_file
    result = Sheller.execute('grep', 'Dublin', Sheller::STDIN_FROM_FILE, './fixtures/cities.txt')
    assert_equal "Dublin\n", result.stdout
  end
  
  def test_command
    result = Sheller.execute('echo', 'barnacle')
    assert_equal "'echo' 'barnacle'", result.command
  end
end
