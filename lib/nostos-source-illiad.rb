# Source::Illiad, Nostos Source Driver for Illiad

require 'nostos-source-illiad/railtie.rb' if defined?(Rails)
require 'nostos-source-illiad/config.rb'
require 'nostos-source-illiad/record.rb'
require 'illiad'
require 'illiad/transaction.rb'
require 'nostos-source-illiad/generators/source_illiad_generator.rb'


module Source
  module Illiad 
    def self.config
      @@config ||= Source::Illiad::Config.new
    end

    def self.configure
      yield self.config
    end

    def self.find(id)
      ::Illiad::AR::Transaction.find(id).to_record
    end

    # Poll Illiad for new transactions to process. The strategy is to find
    # all transactions that have had the status Customer Notified Via E-Mail
    # within the past `number_of_days_old_transactions` days. We must join
    # the Tracking table because a transaction theoretically could go from
    # `Customer Notified Via E-Mail` to another status quicker than our
    # processing runs.
    def self.poll
      # SQL to identify records as old as 60 days
      sql = <<-SQL
        SELECT
          Tracking.TransactionNumber
        , Username
        , LoanTitle
        , LoanAuthor
        , DueDate
        , TransactionStatus
        FROM
          Tracking
          INNER JOIN Transactions ON Tracking.TransactionNumber = Transactions.TransactionNumber
        WHERE
          Tracking.ChangedTo = 'Customer Notified Via E-Mail' AND
          Tracking.DateTime > CURRENT_TIMESTAMP - #{config.number_of_days_to_poll} AND
          Transactions.RequestType = 'Loan'
      SQL

      ::Illiad::AR::Transaction.find_by_sql(sql).map {|t| t.to_record}
    end
  end
end
