require 'open3'

module Sheller
  INESCAPABLE_ARGS = [ :> ]
  INESCAPABLE = Hash[INESCAPABLE_ARGS.map { |a| [ a, true ] }]
  
  class << self
    def command(*args)
      args.map { |a| arg_to_cmd(a) }.join(' ')
    end
    
    def execute(*args)
      ShellerResult.new(*Open3.popen3(command(*args)))
    end
    
    private
    def arg_to_cmd(arg)
      INESCAPABLE[arg] ?
        arg.to_s :
        "\"%s\"" % arg.gsub('"', '\"')
    end
  end
  
  class ShellerResult
    attr_reader 'stdout', 'stderr'
    
    def initialize(_, stdout, stderr)
      @stdout = stdout.read
      @stderr = stderr.read
    end
  end
end
