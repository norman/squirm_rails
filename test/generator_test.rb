require File.expand_path("../helper", __FILE__)

class SquirmRailsGeneratorTest < Rails::Generators::TestCase

  tests Squirm::Install
  destination File.expand_path("../../tmp", __FILE__)

  setup :prepare_destination

  def teardown
    FileUtils.rm_rf self.destination_root
  end

  test "should generate functions.sql" do
    run_generator
    assert_file "db/functions.sql"
  end

  test "should generate unit test" do
    run_generator
    assert_file "test/unit/stored_procedures/hello_world_test.rb"
  end
end
