module Sheller
  class << self
    def execute(cmd)
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
