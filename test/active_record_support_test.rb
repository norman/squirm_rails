require File.expand_path("../helper", __FILE__)

class ActiveRecordSupportTest < MiniTest::Unit::TestCase
  test "#procedure should define an instance method that invokes a procuedure of the same name" do
    model_class = Class.new(Person) do
      procedure "hello_world"
    end
    assert model_class.public_instance_methods.include? :hello_world
    assert_equal "hello world!", model_class.new.hello_world
  end

  test "#procedure should define class method that invokes a procuedure of the same name" do
    model_class = Class.new(Person) do
      procedure "hello_world"
    end
    assert model_class.public_methods.include? :hello_world
    assert_equal "hello world!", model_class.hello_world
  end

  test "#procedure should pass instance variables matching procedure argument names" do
    model_class = Class.new(Person) do
      procedure "return_name_and_email"
    end
    person = model_class.new name: "foo", email: "bar"
    assert_equal "foo bar", person.return_name_and_email
  end
end
