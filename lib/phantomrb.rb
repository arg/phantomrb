require 'phantomrb/version'
require 'phantomrb/errors'
require 'phantomrb/configuration'
require 'phantomrb/runner'

module Phantomrb
  class << self
    # Returns the global configuration.
    # @return [Object] configuration
    def configuration
      @configuration ||= Configuration.new
    end

    # Yields the global configuration to a block.
    # @yield global configuration
    #
    # @example
    #     Phantomrb.configure do
    #       parameter 'ignore-ssl-errors', true
    #     end
    def configure(&block)
      configuration.instance_eval(&block) if block_given?
    end

    # Runs JavaScript file.
    # @param script [String] path for a script
    # @param args [String] script arguments
    # @yieldparam line [String] line from stdout
    # @return [OpenStruct] data
    #   * <b>output</b> (String) --- full stdout from PhantomJS
    #   * <b>exit_status</b> (Integer) --- exit status code
    #   * <b>command_line</b> (String) --- full command line
    #
    # @example Simple output
    #   puts Phantomrb.run('echo.js', 'test').output #=> "test"
    #
    # @example Each line separate output
    #   Phantomrb.run('echo.js', 'test') do |line|
    #     puts line #=> "test"
    #   end
    def run(script, *args, &block)
      @runner ||= Runner.new
      @runner.run(script, args, &block)
    end
  end
end
