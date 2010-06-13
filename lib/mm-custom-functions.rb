require 'mongo_mapper'

module MongoMapper
  module CustomFunctions

    @@load_dir = nil
    def self.load_dir
      @@load_dir
    end

    def self.load_dir=(dir)
      @@load_dir = dir
    end

    # wipes all custom functions
    def self.clear
      MongoMapper.database.eval("db.system.js.remove({});")
    end

    # wipes all functions and reloads
    def self.reset
      clear
      reload
    end

    # updates all functions in the load dir
    def self.reload
      functions.each do |func|
        install_function(func)
      end
    end

    # updates a specific function
    def self.load(name)
      install_function(function(name))
    end

    # returns all functions in the load_dir as an array of hashes:
    # returns array of
    # {
    #   _id   => file name (without the extension),
    #   value => file contents
    # }
    def self.functions
      Dir[File.join(load_dir, '*.js')].collect do |path|
        func_from_file(path)
      end
    end

    # find one specific function defined in the load_dir
    def self.function(name)
      func_from_file(File.join(load_dir, "#{name}.js"))
    end

    private

    def self.func_from_file(path)
      contents = File.read(path)
      name     = File.basename(path).gsub(/\.js$/, '')
      {
        :_id   => name,
        :value => contents
      }
    end

    def self.install_function(func)
      MongoMapper.database.eval("db.system.js.update({_id: '#{func[:_id]}'}, #{func.to_json}, true)")
    end

  end
end