require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NationBuilder::Client do
  shared_examples 'request' do
    let(:client) { double }

    subject { NationBuilder::Client.new(hostname: 'nationbuilder.com') }

    before :each do
      expect(subject).to receive(:client).and_return(client)
    end

    context 'request path does not include ID' do
      let(:request_path) { 'foo/bar' }

      before :each do
        expect(client).to receive(request_type).with('https://nationbuilder.com/foo/bar', hash_including(headers: subject.send(:headers)))
      end

      it 'should perform instrumented request if instrumentation set' do
        instrumentation = double
        expect(instrumentation).to receive(:call).with(hash_including(path: request_path, request_type: request_type))
        expect(subject).to receive(:instrumentation).at_least(:once).and_return(instrumentation)

        subject.send(request_type, request_path)
      end

      it 'should perform uninstrumented request if instrumentation not set' do
        expect(subject).to receive(:instrumentation).and_return(nil)

        subject.send(request_type, request_path)
      end
    end

    context 'request path includes ID' do
      let(:request_path) { 'foo/123/bar' }

      before :each do
        expect(client).to receive(request_type).with('https://nationbuilder.com/foo/123/bar', hash_including(headers: subject.send(:headers)))
      end

      it 'should perform instrumented request normalizing path' do
        instrumentation = double
        expect(instrumentation).to receive(:call).with(hash_including(path: 'foo/_/bar', request_type: request_type))
        expect(subject).to receive(:instrumentation).at_least(:once).and_return(instrumentation)

        subject.send(request_type, request_path)
      end
    end
  end

  [:get, :post, :put, :delete].each do |request|
    describe "##{request}" do
      it_behaves_like 'request' do
        let(:request_type) { request }
      end
    end
  end
end
