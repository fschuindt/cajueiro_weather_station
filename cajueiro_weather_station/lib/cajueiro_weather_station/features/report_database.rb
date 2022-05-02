module CajueiroWeatherStation
  module Features
    class ReportDatabase
      attr_accessor :report

      def initialize
        @report = nil
      end

      def write(report)
        @report = report
      end

      def read
        @report
      end
    end
  end
end
