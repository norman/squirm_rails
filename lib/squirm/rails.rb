require "squirm"
require "squirm/rails/connection_pool"
require "squirm/rails/active_record_support"

module Squirm
  module Rails

    class Railtie < ::Rails::Railtie
      initializer "squirm.setup" do
        Squirm.connect pool: ConnectionPool.new
        ActiveRecord::Base.extend ActiveRecordSupport
      end

      rake_tasks do
        load File.expand_path("../rails/squirm.rake", __FILE__)
      end

      generators do
        require File.expand_path("../rails/generator", __FILE__)
      end
    end
  end
end