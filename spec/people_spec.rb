require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'People' do
  describe 'list' do

    let(:body) { fixture('people_get') }
    let(:request_path) { '/api/v1/people' }
    let(:status) { 200 }
    let(:client) { NationBuilder::Client.new(hostname: 'controlshifttest.nationbuilder.com', client_id: 'be4e96f9c1c664b1903764cc425f522e4adbc3f26f0e6b52603f7e68e1ed025e', client_secret: '3dbafb54fb670fb6b2323a617d3cafbee7a83943cf5340347dcbe40fe13d93f7', username: 'nathan@controlshiftlabs.com', password: '9WRv9pZRwaUJuv') }
    before(:each) do
      stub_get(request_path).to_return(:body => body, :status => status,
                                                                 :headers => { content_type: "application/json; charset=utf-8"})
    end

    describe 'on success' do
      describe 'empty list' do
      let(:body) { fixture('people_list_empty') }
        it 'should return an empty result set if the nation is empty' do
          pending "figure out how to stub oauth2"
          client.people.list.should be_a(Hash)
          client.people.list['results'].should be_empty
        end
      end 

      describe 'succesful response' do
        let(:body) { fixture('people_list_success') }
        it 'should return a list of people in the nation' do
          pending "figure out how to stub oauth2"
        
          client.people.list.should be_a(Hash)
          client.people.list.should_not be_empty
        end
      end
    end
  end
end