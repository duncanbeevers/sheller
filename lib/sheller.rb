module Sheller
  class << self
    def execute(*args)
      cmd = args.map { |a| "\"%s\"" % a.gsub('"', '\"') }.join(' ')
      ShellerResult.new(`#{cmd}`)
    end
  end
  
  class ShellerResult
    attr_reader 'stdout'
    
    def initialize(stdout)
      @stdout = stdout
    end
  end
end
