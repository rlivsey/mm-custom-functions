$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
gem 'rspec'

require 'mm-custom-functions'
require 'spec'

logger = Logger.new("mongo-spec.log")
MongoMapper.connection = Mongo::Connection.new('127.0.0.1', 27017, :logger => logger)
MongoMapper.database = 'mm-custom-functions-spec'

MongoMapper::CustomFunctions.load_dir = File.join(File.dirname(__FILE__), 'functions')

Spec::Runner.configure do |config|
  config.before(:each) do
    MongoMapper.database.eval("db.system.js.remove({});")
  end
end
