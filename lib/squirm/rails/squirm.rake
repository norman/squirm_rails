namespace :db do
  namespace :functions do
    task :load => :environment do
      functions = File.read(Rails.root.join("db", "functions.sql"))
      ActiveRecord::Base.connection.execute functions
    end
  end

  namespace :schema do
    task :load do
      Rake::Task["db:functions:load"].invoke
    end
  end
end