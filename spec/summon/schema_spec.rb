require File.dirname(__FILE__) + '/../spec_helper'

describe Summon::Schema do
  
  before(:each) do
    @class = Class.new(Summon::Schema)
  end

  def class_eval(&block)
    @class.class_eval(&block)
  end
  
  def init(values)
    @class.new(mock(:service, :locale => 'en'), values)
  end
  
  it "pulls its attributes from a hash" do
    class_eval do
      attr :foo 
      attr :baz
    end
    
    init(:foo => "bar", :baz => "bang").foo.should == "bar"
  end
  
  it "can pull its attributes from string keys as well as symbol keys" do
    class_eval do
      attr :foo
    end
    
    init("foo" => "bar").foo.should == "bar"
  end
  
  it "knows how to atomagically map between camel case and perl case" do
    class_eval do
      attr :foo_bar_baz
    end
    
    init("fooBarBaz" => "Hello").foo_bar_baz.should == "Hello"
  end
  
  it "can also magically convert from Pascal case as well" do
    class_eval do
      attr :foo_bar_baz
    end
    init("FooBarBaz" => "Hello").foo_bar_baz.should == "Hello"
  end
  
  it "can have an overridden field name for names that don't map so cleanly" do
    class_eval do
      attr :isbn, :json_name => "ISBN"
      attr :eissn, :json_name => "eISSN"
    end
    
    o = init("ISBN" => 123456, "eISSN" => 98765)
    o.isbn.should == 123456
    o.eissn.should == 98765    
  end

  describe "transforms" do
    it "can transform subobjects" do
      class Summon::DogPile < Summon::Schema
        attr :type
      end
      class_eval do
        attr :steaming, :transform => :DogPile
      end

      o = init("steaming" => {:type => "swirled"})
      o.steaming.should_not be_nil
      o.steaming.type.should == "swirled"
    end

    it "should accept a class as transformer" do
      class Summon::DogHouse < Summon::Schema
        attr :type
      end
      class_eval do
        attr :place, :transform => Summon::DogHouse
      end

      o = init('place' => {:type => 'fancy'})
      o.place.should_not be_nil
      o.place.type.should == 'fancy'
    end

    it "should accept an array of symbols as transformer" do
      module Summon::Pets; end
      class Summon::Pets::PitBull < Summon::Schema
        attr :name
      end
      class_eval do
        attr :dog, :transform => [:pets, :pit_bull]
      end

      o = init('dog' => {:name => 'Fido'})
      o.dog.should_not be_nil
      o.dog.name.should == "Fido"
    end
  
    it "will apply a transform across an array if the field is an array" do
      class Summon::DogPatch < Summon::Schema
        attr :foo
      end
      class_eval do
        attr :patches, :transform => :DogPatch
      end
      patches = init("patches" => [{:foo => 'bar'},{:foo => 'baz'}, {:foo => 'bang'}]).patches
      patches.should_not be_nil
      patches.should be_kind_of(Array)
      patches.collect{|p| p.foo}.should == ['bar', 'baz', 'bang']
    end
  
    it "will ignore a transform if the element is not present" do
      class Summon::DogFood < Summon::Schema
        attr :foo
      end
      class_eval do
        attr :kibbles, :transform => :DogPatch
        attr :bits, :single => true, :transform => :DogPatch
      end
      foo = init({})
      foo.kibbles.should == []
      foo.bits.should == nil
    end
  end
  
  it "will create a predicate if the field is marked as boolean" do
    class_eval do
      attr :boollocks, :boolean => true
    end
    
    init("isBoollocks" => true).boollocks?.should be(true)
  end
  
  it "will automatically do a bean styles lookup on attributes that end in a question mark" do
    class_eval do
      attr :awesome?
    end
    init("isAwesome" => true).should be_awesome
    init("isAwesome" => false).should_not be_awesome
  end
  
  it "automatically unwraps arrays from values if the value is marked as being single" do
    class_eval do
      attr :just_one, :single => true
    end
    init(:justOne => ["foo"]).just_one.should == 'foo'
  end
  
  it "defaults to automatically unwrap arrays if the field doesn't end in s" do
    class_eval do
      attr :foo
      attr :foos
    end
    o = init(:foo => ["bar"], :foos => ["bar"])
    o.foo.should == "bar"
    o.foos.should == ["bar"]
  end
  
  it "initializes multi-valued fields to the empty array if it is not present" do
    class_eval do
      attr :foos
    end
    init({}).foos.should == []
  end
end
