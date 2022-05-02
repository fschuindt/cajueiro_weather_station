require 'aws-sdk-s3'
require 'serialport'
require 'gruff'
require 'csv'
require 'date'

require 'cajueiro_weather_station/configuration'

require 'cajueiro_weather_station/features/main'
require 'cajueiro_weather_station/features/graph_file_generator'
require 'cajueiro_weather_station/features/graph_builder_and_uploader'
require 'cajueiro_weather_station/features/report_database'
require 'cajueiro_weather_station/features/system_reporter'

module CajueiroWeatherStation
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield configuration
  end
end
