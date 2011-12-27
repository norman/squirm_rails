require 'test_helper'

module StoredProcedureTests

  class HelloWorldTest < ActiveSupport::TestCase
    def setup
      @procedure = Squirm.procedure "hello_world"
    end

    test "hello_world should emit a greeting" do
      assert_equal "hello world!", @procedure.call
    end
  end

end