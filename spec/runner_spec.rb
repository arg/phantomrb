describe Phantomrb::Runner do
  before :all do
    Phantomrb.configure do
      option('load-images', false)
    end
  end

  it 'sets the correct executable command' do
    runner = Phantomrb::Runner.new
    expect(runner.instance_variable_get(:'@command')).to include('phantomjs')
  end

  it 'sets the correct command line parameters' do
    runner = Phantomrb::Runner.new
    expect(runner.instance_variable_get(:'@command')).to include('--load-images=false')
  end
end
