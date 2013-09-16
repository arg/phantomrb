module Phantomrb
  class Configuration
    attr_reader :options, :executable

    def initialize
      @options = {}
      @executable = 'phantomjs'
    end

    def option(key, value)
      @options[key] = value
    end
  end
end
