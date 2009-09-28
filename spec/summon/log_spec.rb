
require File.dirname(__FILE__) + '/../spec_helper'

describe Summon::Log do

  before(:each) do
    @logger = stub(:Logger)
  end
  
  it "passes through all methods to the underlying logger" do
    log = Summon::Log.new(@logger)
    @logger.should_receive(:info).with("foo")
    log.info("foo")
  end
  
  it "creates a stderr logger when no spec is provided" do
    Logger.should_receive(:new).with($stderr).and_return(@logger)
    @logger.should_receive(:level=).with(Logger::WARN)
    log = Summon::Log.new    
  end
  
  it "creates a logger from an option hash when the spec is a set of options" do
    out = stub(:OutputStream)
    Logger.should_receive(:new).with(out).and_return(@logger)
    @logger.should_receive(:level=).with(Logger::ERROR)
    log = Summon::Log.new(:level => :error, :initialize => [out])
  end
end