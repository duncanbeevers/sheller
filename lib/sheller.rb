require 'fileutils'

module Sheller
  INESCAPABLE_ARGS = [ :> ]
  INESCAPABLE = Hash[INESCAPABLE_ARGS.map { |a| [ a, true ] }]
  
  class << self
    def command(*args)
      args.map { |a| arg_to_cmd(a) }.join(' ')
    end
    
    def execute(*args)
      ShellerResult.new(`#{command(*args)}`)
    end
    
    private
    def arg_to_cmd(arg)
      INESCAPABLE[arg] ?
        arg.to_s :
        "\"%s\"" % arg.gsub('"', '\"')
    end
  end
  
  class ShellerResult
    attr_reader 'stdout'
    
    def initialize(stdout)
      @stdout = stdout
    end
  end
end
