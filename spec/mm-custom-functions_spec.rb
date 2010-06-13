require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MongoMapper::CustomFunctions" do

  describe "#clear" do
    it "should wipe out any existing system functions" do
      MongoMapper.database.eval("db.system.js.insert({_id:'test', value: 'function(){}'})")
      MongoMapper.database.eval("db.system.js.count()").should == 1
      MongoMapper::CustomFunctions.clear
      MongoMapper.database.eval("db.system.js.count()").should == 0
    end
  end

  describe "#reset" do
    it "should wipe out functions which are not in js files" do
      MongoMapper.database.eval("db.system.js.insert({_id:'test', value: 'function(){}'})")
      MongoMapper::CustomFunctions.reset
      MongoMapper.database.eval("db.system.js.findOne({_id:'test'})").should be_nil
    end
    
    it "should replace functions which are already defined" do
      MongoMapper.database.eval("db.system.js.insert({_id:'one', value: 'function(){ return 99; }'})")
      MongoMapper::CustomFunctions.reset
      MongoMapper.database.eval("db.system.js.findOne({_id:'one'})")["value"].should == 'function(){ return 1; }'
    end
  end

  describe "#reload" do
    it "should not wipe out functions which are not in js files" do
      MongoMapper.database.eval("db.system.js.insert({_id:'test', value: 'function(){}'})")
      MongoMapper::CustomFunctions.reload
      MongoMapper.database.eval("db.system.js.findOne({_id:'test'})").should_not be_nil
    end
    
    it "should replace functions which are already defined" do
      MongoMapper.database.eval("db.system.js.insert({_id:'one', value: 'function(){ return 99; }'})")
      MongoMapper::CustomFunctions.reload
      MongoMapper.database.eval("db.system.js.findOne({_id:'one'})")["value"].should == 'function(){ return 1; }'
    end
  end

  describe "#load" do
    it "should add the function to the system functions" do
      MongoMapper::CustomFunctions.load(:one)
      func = MongoMapper.database.eval("db.system.js.findOne({_id:'one'})")
      func.should_not be_nil
      func["value"].should == "function(){ return 1; }"
    end
    
    it "should throw an exception if the function doesn't exist" do
      lambda{
        MongoMapper::CustomFunctions.load(:monkey)
      }.should raise_error
    end
  end

  describe "#functions" do
    it "should return an array of defined functions" do
      funcs = MongoMapper::CustomFunctions.functions
      funcs.should be_an(Array)
      funcs.size.should == 3
    end
  end
  
  describe "#function" do
    it "should return the correct function from the load dir" do
      func = MongoMapper::CustomFunctions.function(:one)
      func[:_id].should == "one"
      func[:value].should == "function(){ return 1; }"
    end
  end
end
