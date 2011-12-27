# Squirm::Rails

Squirm::Rails lets you comfortably use Postgres stored procedures with Rails /
Active Record.

It's built upon [Squirm](https://github.com/bvision/squirm), a lightweight,
Postgres-specific library for stored procedures.

## Quick start

    rails new my_app
    cd my_app
    # edit config/database.yml - make it use Postgres
    # edit Gemfile:
    gem "squirm_rails", require: "squirm/rails"
    bundle
    rails generate squirm:install

    # Take a peek at the default stored procedures:
    # edit db/functions.sql
    # edit test/unit/stored_procedures/hello_world_test.rb

    bundle exec rake db:setup
    bundle exec rake db:migrate

## Integration with Active Record

Squirm::Rails provides a `procedure` class method in AR models, which adds method
wrappers around a stored procedure by the given name:

    CREATE OR REPLACE FUNCTION say_my_name(_name text) RETURNS TEXT AS $$
      BEGIN
        RETURN _name;
      END;
    $$ LANGUAGE 'PLPGSQL'

    class Person < ActiveRecord::Base
      procedure :say_my_name
    end

This method adds a class method with the same name as the stored procedure, so that
the procedure can be invoked with any arguments:

    Person.say_my_name("foo") #=> "foo"

It also adds an instance method with the same name as the procedure, which
automatically pass any matching attribute names as stored procedure arguments:

    person = Person.new name: "John"
    person.say_my_name #=> "John"

## Migrations and Rake Tasks

Squirm::Rails defines stored procedures not in migrations, but rather in the
`db/functions.sql` file. Stored procedures are neither data nor structure, but
rather project code - just like your Ruby code. So you version it with Git or
another SCM, not with migrations.

You can reload the stored procedures any time with: `db:functions:load`, as long
as you're careful to define them with `CREATE OR REPLACE`. This Rake task is
invoked by `db:schema:load`, so your unit tests will pick up your modifications
automatically - most of the time there will be no need to manually reload the
functions.

## Author

Norman Clarke <nclarke@bvision.com>

## License

Copyright (c) 2011-2012 Norman Clarke and Business Vision S.A.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
