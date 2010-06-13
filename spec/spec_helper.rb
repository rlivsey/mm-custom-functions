$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
gem 'rspec'

require 'mm-custom-functions'
require 'spec'

MongoMapper.database = 'mm-custom-functions-spec'

MongoMapper::CustomFunctions.load_dir = File.join(File.dirname(__FILE__), 'functions')

Spec::Runner.configure do |config|
  config.before(:each) do
    MongoMapper.database.eval("db.system.js.remove({});")
  end
end
