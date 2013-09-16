describe Phantomrb do
  let(:js_test_script) { 'spec/test.js' }

  describe '::configure' do
    before :all do
      Phantomrb.configure do
        option('ignore-ssl-errors', true)
      end
    end

    it 'has the correct executable command' do
      expect(Phantomrb.configuration.executable).to eq('phantomjs')
    end

    it 'allows to set parameters' do
      expect(Phantomrb.configuration.options).to eq({ 'ignore-ssl-errors' => true })
    end
  end

  describe '::run' do
    describe Phantomrb::ExecutableLoadError do
      before do
        Phantomrb.configuration.instance_variable_set(:'@executable', 'sjmotnahp')
        Phantomrb.instance_variable_set(:'@runner', nil)
      end

      after do
        Phantomrb.configuration.instance_variable_set(:'@executable', 'phantomjs')
        Phantomrb.instance_variable_set(:'@runner', nil)
      end

      it 'raises an exception if PhantomJS not found' do
        expect { Phantomrb.run(js_test_script) }.to raise_exception(Phantomrb::ExecutableLoadError)
      end
    end

    describe Phantomrb::ScriptLoadError do
      it 'raises an exception if script file not found' do
        expect { Phantomrb.run('none.js') }.to raise_exception(Phantomrb::ScriptLoadError)
      end
    end

    describe 'Result object' do
      subject { Phantomrb.run(js_test_script) }

      it 'has correct type' do
        expect(subject).to be_an(OpenStruct)
      end

      it 'contains the correct exit status code' do
        expect(subject.exit_status).to eq(123)
      end

      it 'contains output string' do
        expect(subject.output).to eq("test\n")
      end

      it 'contains command line string' do
        expect(subject.command_line).to_not be_empty
      end
    end

    it 'passes parameters to a script' do
      expect(Phantomrb.run(js_test_script, 1, 2, 3).output).to eq("test\n1\n2\n3\n")
    end

    it 'invokes a block on each output line' do
      output = ''
      Phantomrb.run(js_test_script, 1, 2, 3) { |line| output << line }
      expect(output).to eq("test\n1\n2\n3\n")
    end
  end
end
