if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

require "bundler/setup"
require "minitest/unit"
require 'minitest/autorun'

require "active_record"
require "rails"

ActiveRecord::Base.establish_connection \
  :adapter   => "postgresql",
  :host      => "localhost",
  :database  => "squirm_test",
  :pool_size => 2

# $VERBOSE = true

require "squirm/rails"
require "squirm/rails/generator"

ActiveRecord::Base.extend Squirm::Rails::ActiveRecordSupport

Squirm.connect pool: Squirm::Rails::ConnectionPool.new

Squirm do
  exec "DROP TABLE IF EXISTS people"
  exec "CREATE TABLE people(id SERIAL, name VARCHAR(126), email VARCHAR(128))"
  exec %q{
    CREATE OR REPLACE FUNCTION hello_world() RETURNS TEXT AS $$
      BEGIN
        RETURN 'hello world!';
      END;
    $$ LANGUAGE 'PLPGSQL'
  }
  exec %q{
    CREATE OR REPLACE FUNCTION return_name_and_email(_name text, _email text) RETURNS TEXT AS $$
      BEGIN
        RETURN _name || ' ' || _email;
      END;
    $$ LANGUAGE 'PLPGSQL'
  }
end

class Module
  def test(name, &block)
    define_method("test_#{name.gsub(/[^a-z0-9']/i, "_")}".to_sym, &block)
  end
end

class Person < ActiveRecord::Base
end