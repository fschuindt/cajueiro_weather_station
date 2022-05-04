require "cajueiro_weather_station"

CajueiroWeatherStation::Features::GraphFileGenerator.generate("../sensor_data/temperature_data.csv", 10000, 2500)
