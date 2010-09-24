require 'POpen4'

module Sheller
  VERSION = '0.0.1'
  
  INESCAPABLE_ARGS = [ :>, :|, :<, :>>, :'>&2', :'1>&2' ]
  INESCAPABLE = Hash[INESCAPABLE_ARGS.map { |a| [ a, true ] }]
  
  SHELL_SAFE = /\A[0-9A-Za-z+,.\/:=@_-]+\z/
  ARG_SCAN = /('+)|[^']+/
  
  class << self
    def command(*args)
      args.map { |a| arg_to_cmd(a) }.join(' ')
    end
    
    def execute(*args)
      stdout, stderr = nil
      status = POpen4.popen4(command(*args)) do |_stdout, _stderr, _stdin, _pid|
        stdout = _stdout.read
        stderr = _stderr.read
      end
      ShellerResult.new(stdout, stderr, status)
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
    attr_reader 'stdout', 'stderr', 'exit_status'
    
    def initialize(stdout, stderr, exit_status)
      @stdout = stdout
      @stderr = stderr
      @exit_status = exit_status
    end
  end
end
