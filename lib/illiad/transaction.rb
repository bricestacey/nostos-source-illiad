# Extend Illiad::Transaction to map to a Source::Illiad object.
module Illiad
  module AR
    class Transaction
      def to_record
        Source::Illiad::Record.new(:id => read_attribute(:TransactionNumber),
                                   :title => read_attribute(:LoanTitle),
                                   :due_date => read_attribute(:DueDate),
                                   :charged => charged?)
      end
    end
  end
end
