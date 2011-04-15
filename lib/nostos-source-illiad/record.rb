require 'mechanize'

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
          t = IlliadAR::AR::Transaction.find(@id)
          @due_date = t.due_date
          @charged = t.charged?
        end

        @charged
      end

      def charge!
        # Create a new mechanize object
        agent = Mechanize.new# { |a| a.log = Logger.new(STDERR) }

        # Load Illiad Web Circulation
        page = agent.get(Source::Illiad.config.webcirc[:url])

        # Select, fill in, and submit the logon form.
        page = page.form('formLogon') do |f|
          f.TextBoxUsername = Source::Illiad.config.webcirc[:username]
          f.TextBoxPassword = Source::Illiad.config.webcirc[:password]
        end.click_button

        # Mechanize::ResponseCodeError - 500 => Net::HTTPInternalServerError:
        # catch these and try again.
        page = page.form('aspnetForm') do |f|
          f['ctl00$TextBoxCheckOutTransaction'] = @id
        end.click_button

        if !page.at("#ctl00_UpdatePanelStatusMessages .success").nil?
          type = 'success'
        elsif !page.at("#ctl00_UpdatePanelStatusMessages .warning").nil?
          type = 'failure'
        else
          type = 'error'
        end

        puts "#{@id} - #{@title}"
        puts page.at("#ctl00_UpdatePanelStatusMessages .failure, #ctl00_UpdatePanelStatusMessages .success, #ctl00_UpdatePanelStatusMessages .warning").inner_html
      end

      private

      attr_reader :charged
      attr_writer :id, :title, :due_date, :charged
    end
  end
end
