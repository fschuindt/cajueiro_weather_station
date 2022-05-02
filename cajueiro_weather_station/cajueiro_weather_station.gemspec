require_relative 'lib/cajueiro_weather_station/version'

Gem::Specification.new do |spec|
  spec.name          = "cajueiro_weather_station"
  spec.version       = CajueiroWeatherStation::VERSION
  spec.authors       = ["Fernando Schuindt"]
  spec.email         = ["f.schuindtcs@gmail.com"]

  spec.summary       = %q{}
  spec.homepage      = "https://fschuindt.github.io/blog/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "https://gitlab.com/msdoc/opal/cajueiro_weather_station"

  spec.files = [
    'lib/cajueiro_weather_station.rb',
    'lib/cajueiro_weather_station/configuration.rb',
    'lib/cajueiro_weather_station/version.rb',
    'lib/cajueiro_weather_station/features/main.rb',
    'lib/cajueiro_weather_station/features/graph_file_generator.rb',
    'lib/cajueiro_weather_station/features/graph_builder_and_uploader.rb',
    'lib/cajueiro_weather_station/features/report_database.rb',
    'lib/cajueiro_weather_station/features/system_reporter.rb'
  ]

  spec.bindir        = "bin"
  spec.executables   = ["cajueiro_weather_station"]
  spec.require_paths = ["lib"]

  spec.add_dependency "serialport", "~> 1.3"
  spec.add_dependency "gruff", "~> 0.14.0"
  spec.add_dependency "aws-sdk-s3", "~> 1.113", ">= 1.113.2"
end
