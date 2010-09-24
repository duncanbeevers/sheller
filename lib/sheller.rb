module Sheller
  class << self
    def execute(cmd)
      { :STDOUT => `#{cmd}` }
    end
  end
end
