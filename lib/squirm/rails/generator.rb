require "rails/generators"

module Squirm
  class Install < ::Rails::Generators::Base
    source_root File.dirname(__FILE__)
    def install_functions
      copy_file "functions.sql", "db/functions.sql"
      copy_file "unit_test.rb", "test/unit/stored_procedures/hello_world_test.rb"
    end
  end
end