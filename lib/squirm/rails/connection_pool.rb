module Squirm
  module Rails
    class ConnectionPool

      def initialize
        @pool = ActiveRecord::Base.connection_pool
        @map  = {}
      end

      def checkout
        conn = @pool.checkout
        raw_connection = conn.raw_connection
        @map[raw_connection.object_id] = conn
        raw_connection
      end

      def checkin(raw_connection)
        @pool.checkin @map[raw_connection.object_id]
      end
    end
  end
end