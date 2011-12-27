module Squirm

  module Rails

    # Support for working with procedures inside Active Record models. This
    # exists primarily to ensure that stored procedure calls are done inside the
    # same connection  used by the AR model, to avoid transaction opacity issues
    # that could arise if AR and Squirm are used different connections.
    module ActiveRecordSupport

      def procedure(name, options = {}, &block)
        name = options[:as] || name

        self.class_eval(<<-EOM, __FILE__, __LINE__ + 1)
          @@__squirm ||= {}
          @@__squirm[:#{name}] = Squirm.procedure("#{name}")

          def self.#{name}(options = {})
            Squirm.use(connection.raw_connection) do
              @@__squirm[:#{name}].call(options)
            end
          end

          def #{name}(options = {})
            proc_args = @@__squirm[:#{name}].arguments
            args = proc_args.inject({}) {|m, o| m[o] ||= try(o); m}
            self.class.#{name}(args.merge(options))
          end
        EOM
      end
    end
  end
end