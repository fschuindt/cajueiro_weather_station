module CajueiroWeatherStation
  module Features
    class SystemReporter
      def self.start(report_database)
        Thread.new do
          loop do
            report_database.write(report())
            sleep 5
          end
        end
      end

      def self.memory_utilization
        `free -h | awk 'FNR == 2 {printf("%.0f"), 100 - (($7/$2)*100)}'`.to_i
      end

      def self.cpu_usage
        100 - `echo "$(vmstat 1 2|tail -1|awk '{print $15}')"`.strip.to_i
      end

      def self.cpu_temperature
        `sensors | awk 'FNR == 3 {printf("%.1f"), $2}'`.to_f
      end

      def self.disk_utilization
        `df -h | awk 'FNR == 5 {printf("%.0f"), $5}'`.to_i
      end

      def self.report
        """
        CPU: #{cpu_usage}% / CPU Temp.: #{cpu_temperature} °C / Memory: #{memory_utilization}% / Storage: #{disk_utilization}%
        """.strip
      end
    end
  end
end
