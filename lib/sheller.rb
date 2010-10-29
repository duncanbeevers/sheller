require 'popen4'

module Sheller
  VERSION = '0.0.4'
  
  INESCAPABLE = {}
  
  {
    'STDOUT_TO_FILE'            => :>,
    'STDOUT_TO_PIPE'            => :|,
    'STDOUT_APPEND_TO_FILE'     => :>>,
    'STDOUT_TO_STDERR'          => :'1>&2',
    'STDERR_TO_FILE'            => :'2>',
    'STDERR_TO_STDOUT'          => :'2>&1',
    'STDERR_APPEND_TO_FILE'     => :'2>>',
    'STDOUT_AND_STDERR_TO_FILE' => :'&>',
    'STDIN_FROM_FILE'           => :<
  }.each do |c, s|
    const_set(c, s)
    INESCAPABLE[s] = s.to_s
  end
  
  SHELL_SAFE = /\A[0-9A-Za-z+,.\/:=@_-]+\z/
  ARG_SCAN = /('+)|[^']+/
  
  class << self
    def command(*args)
      args.map { |a| arg_to_cmd(a) }.join(' ')
    end
    
    def execute(*args)
      stdout, stderr = nil
      shell_command = command(*args)
      status = POpen4.popen4(shell_command) do |_stdout, _stderr, _stdin, _pid|
        stdout = _stdout.read
        stderr = _stderr.read
      end
      ShellerResult.new(stdout, stderr, status, shell_command)
    end
    
    private
    def arg_to_cmd(arg)
      if INESCAPABLE[arg]
        arg.to_s
      elsif arg.empty? || SHELL_SAFE =~ arg
        "'%s'" % arg
      else
        result = ''
        arg.scan(ARG_SCAN) do
          result << ($1 ? "\\'" * $1.length : "'#{$&}'")
        end
        result
      end
    end
  end
  
  class ShellerResult
    attr_reader 'stdout', 'stderr', 'exit_status', 'command'
    
    def initialize(stdout, stderr, exit_status, command)
      @stdout      = stdout
      @stderr      = stderr
      @exit_status = exit_status
      @command     = command
    end
  end
end
