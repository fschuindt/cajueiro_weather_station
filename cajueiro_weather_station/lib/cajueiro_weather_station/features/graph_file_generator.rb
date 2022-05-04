module CajueiroWeatherStation
  module Features
    class GraphFileGenerator
      def self.process_parsed_rows(rows, label_every)
        labels = {}
        i = 0
        j = 0
        ambient = []
        sky = []

        first_entry_at = ""
        last_entry_at = ""
        rows_count = rows.count

        rows.each do |row|
          first_entry_at = timestamp_to_human_readable(row[0]) if i == 0
          last_entry_at = timestamp_to_human_readable(row[0]) if rows_count == (i+1)

          if j == label_every
            labels.merge!({i => timestamp_to_label(row[0])})
            j = 0
          else
            labels.merge!({i => ""})
          end

          ambient << row[1].to_f
          sky << row[2].to_f

          i += 1
          j += 1
        end

        {
          first_entry_at: first_entry_at,
          last_entry_at: last_entry_at,
          labels: labels,
          ambient: ambient,
          sky: sky
        }
      end

      def self.generate(csv_file, last_n, label_every)
        g = Gruff::Line.new(1600)
        g.theme = {
          colors: %w[orange purple],
          marker_color: "grey",
          font_color: "black",
          background_colors: "white"
        }

        data = `tail -n #{last_n} #{csv_file}`
        rows = CSV.parse(data)
        result = process_parsed_rows(rows, label_every)

        g.title = "IR-radiation-based sky temperature monitoring\nSamples from #{result[:first_entry_at]} to #{result[:last_entry_at]} UTC-3"
        g.title_font_size = 20
        g.labels = result[:labels]
        g.y_axis_label = "Temp. in °C"
        g.data("Ambient temp.", result[:ambient])
        g.data("Sky temp.", result[:sky])
        g.write("ir_radiation_report.png")

        "ir_radiation_report.png"
      end

      def self.parse_timestamp(timestamp)
        DateTime.strptime(timestamp, "%Y-%m-%dT%H:%M:%S")
      end

      def self.datetime_to_label(datetime)
        datetime.strftime("%H:%Mh")
      end

      def self.datetime_to_human_readable(datetime)
        datetime.strftime("%Y-%m-%d %H:%Mh")
      end

      def self.timestamp_to_label(timestamp)
        datetime_to_label(parse_timestamp(timestamp))
      end

      def self.timestamp_to_human_readable(timestamp)
        datetime_to_human_readable(parse_timestamp(timestamp))
      end
    end
  end
end
