require 'ostruct'

module Phantomrb
  class Runner
    def initialize
      config = Phantomrb.configuration
      @command = config.options.reduce(config.executable) do |memo, (key, value)|
        "#{memo} --#{key}=#{value}"
      end
    end

    def run(script, *arguments, &block)
      command_line = "#{@command} #{full_script_path(script)} #{arguments.join(' ')}"
      begin
        process = IO.popen(command_line)
      rescue => e
        raise ExecutableLoadError.new(e)
      end
      output = capture_output(process, &block)
      process.close
      OpenStruct.new(output: output, exit_status: $?.exitstatus, command_line: command_line)
    end

    private

    def full_script_path(script)
      full_script_path = File.expand_path(script)
      if File.file?(full_script_path)
        full_script_path
      else
        raise ScriptLoadError.new("#{full_script_path} not found")
      end
    end

    def capture_output(process)
      if block_given?
        output = ''
        process.each_line do |output_line|
          output << output_line
          yield(output_line)
        end
        output
      else
        process.read
      end
    end
  end
end
