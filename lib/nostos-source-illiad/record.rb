module Source
  module Illiad
    class Record

      def initialize(attributes = {})
        @id = attributes[:id]
        @title = attributes[:title]
        @charged = attributes[:charged]
        @due_date = attributes[:due_date]
      end

      attr_reader :id, :title, :due_date

      def charged?(force = false)
        if force then
          t = IlliadAR::Transaction.find(@id)
          @due_date = t.due_date
          @charged = t.charged?
        end

        @charged
      end

      private

      attr_reader :charged
      attr_writer :id, :title, :due_date, :charged




    end
  end
end
