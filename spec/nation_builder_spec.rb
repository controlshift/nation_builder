require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NationBuilder do
  before(:each) do  
    allow_any_instance_of(NationBuilder::Client).to receive(:setup_client).and_return(true)
  end
  
  specify { expect(subject).to respond_to :people }
  specify { expect(subject.new).to be_a(NationBuilder::Client)}
end
