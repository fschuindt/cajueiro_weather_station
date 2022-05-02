#include <Adafruit_MLX90614.h>

#define En_pin 2
#define Rw_pin 1
#define Rs_pin 0
#define D4_pin 4
#define D5_pin 5
#define D6_pin 6
#define D7_pin 7

Adafruit_MLX90614 mlx = Adafruit_MLX90614();

String ambient;
String object;
String csv_line;

void setup() {
  Serial.begin(9600);
  mlx.begin();
}

void loop() {
  ambient = String(mlx.readAmbientTempC(), 2);
  object = String(mlx.readObjectTempC(), 2);
  csv_line = ambient + "," + object;
  
  Serial.print(csv_line);
  Serial.println("");

  delay(1000);
}
