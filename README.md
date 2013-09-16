# Phantomrb

An interface with PhantomJS for Ruby.

## Dependencies

[PhantomJS](http://phantomjs.org) must be installed on your system.

## Installation

Add this line to your application's Gemfile:

    gem 'phantomrb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phantomrb

## Usage

### Simple

    Phantomrb.run('/path/to/script', arg1, arg2, ...)

### With block

    Phantomrb.run('/path/to/script', arg1, arg2, ...) { |line| ... }

### Notes

* Path can be absolute or relative to app directory.
* All arguments are optional.
* If block is specified it will be called with each line from PhantomJS stdout.

### Example

    // echo.js
    for (var i = 0; i < phantom.args.length; i++) {
        console.log(phantom.args[i]);
    }

In your ruby code:

    Phantomrb.run('echo.js', 'line one', 'line two') { |line| puts line }

Will output:

    test1
    test2

### Return value

Phantomrb returns an OpenStruct object with following data:

* `output` - full stdout from PhantomJS
* `exit_status` - exit status code
* `command_line` - full command line for PhantomJS

## Configuration

Phantomrb provides a way to define a list of command line options for PhantomJS.
Create an initializer `config/initializers/phantomrb.rb` with following code:

    Phantomrb.configure do
      option '<parameter name>', <parameter value>
    end

### Example
    # config/initializers/phantomrb.rb
    Phantomrb.configure do
      option 'load-images', false
      option 'ignore-ssl-errors', true
    end

    Phantomrb.run('myscript.js', 'arg1', 'arg2')

will run `phantomjs --load-images=false --ignore-ssl-errors=true /absolute/path/to/myscript.js arg1 arg2`

More info about PhantomJS command line options you can found in [wiki](https://github.com/ariya/phantomjs/wiki/API-Reference#command-line-options).

## License

Licensed under the MIT license.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
