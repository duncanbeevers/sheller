class Sheller
  class << self
    def execute(cmd)
      `#{cmd}`
    end
  end
end
