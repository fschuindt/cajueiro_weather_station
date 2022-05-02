module CajueiroWeatherStation
  module Features
    class Main
      def self.perform(device, temperature_data_file, draw_file)
        sp = boot_tty(device)
        report_database = ReportDatabase.new()

        SystemReporter.start(report_database)
        GraphBuilderAndUploader.start(temperature_data_file)

        at_exit { shutdown_tty(:exit, sp) }
        trap("INT") { shutdown_tty(:int, sp); exit }

        loop do
          device_line = sp.readline(12)
          sleep 1

          read_device_to_record_csv_line_and_to_write_report_file(device_line, report_database, temperature_data_file, draw_file)
        end
      end

      def self.boot_tty(device)
        puts "Booting TTY device..."

        baud_rate = 9600
        data_bits = 8
        stop_bits = 1
        parity = SerialPort::NONE

        sp = SerialPort.new(device, baud_rate, data_bits, stop_bits, parity)

        puts "Boot finished."

        sp
      end

      def self.shutdown_tty(reason, sp)
        return if sp == nil
        return if reason == :int

        puts "Closing TTY device..."

        sp.flush()
        sp.close()

        puts "Device closed."
      end

      def self.read_device_to_record_csv_line_and_to_write_report_file(value, report_database, temperature_data_file, draw_file)
        values = value.split(",")
        ambient_temp = normalize(values[0])
        object_temp = normalize(values[1])
        now = Time.now
        csv_timestamp = now.strftime("%Y-%m-%dT%H:%M:%S")
        timestamp = now.strftime("%Y-%m-%d %H:%M:%S")
        report = report_database.read()

        return nil if ambient_temp == "0" || object_temp == "0"

        puts "#{timestamp} - Ambient: #{ambient_temp}, Object: #{object_temp}."

        File.open(temperature_data_file, "a") do |file|
          file.puts("#{csv_timestamp},#{ambient_temp},#{object_temp}")
        end

        File.open(draw_file, "w") do |file|
          file.puts("#{timestamp} UTC-3 / Ambient: #{ambient_temp} °C / Target: #{object_temp} °C")
          file.puts(report)
        end
      end

      def self.normalize(string)
        return "0" unless string.is_a?(String)
        return "0" unless string.include?(".")
        return "0" if string.strip.size > 5
        string.strip
      end
    end
  end
end
