module Sheller
  class << self
    def execute(*args)
      ShellerResult.new(`#{args.join(' ')}`)
    end
  end
  
  class ShellerResult
    attr_reader 'stdout'
    
    def initialize(stdout)
      @stdout = stdout
    end
  end
end
