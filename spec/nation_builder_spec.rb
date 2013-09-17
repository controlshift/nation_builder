require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NationBuilder do
  before(:each) do  
    NationBuilder::Client.any_instance.stub(:setup_client).and_return(true)
  end
  
  specify { subject.should respond_to :people }
  specify { subject.new.should be_a(NationBuilder::Client)}
end
