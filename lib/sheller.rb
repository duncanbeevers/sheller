require 'POpen4'

module Sheller
  VERSION = '0.0.1'
  
  INESCAPABLE_ARGS = [ :> ]
  INESCAPABLE = Hash[INESCAPABLE_ARGS.map { |a| [ a, true ] }]
  
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
      # results.push($?)
      ShellerResult.new(stdout, stderr, status)
    end
    
    private
    def arg_to_cmd(arg)
      INESCAPABLE[arg] ?
        arg.to_s :
        "\"%s\"" % arg.gsub('"', '\"')
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
