#include  <Wire.h>  //add library
#include  <LiquidCrystal_I2C.h>
#include "DHT.h"
#include <ModbusRtu.h>

#define TXEN  2   //pin enable transmitter RS458
#define myId  2   //id slave

uint16_t au16data[16] = {
  3, 'A', 12, 4, 2, 12, 12, 8, 0, 0 };  //contoh data yg akan di proses
  
#define DHTPIN1 A0  //pin DHT
#define DHTPIN2 A1
#define DHTPIN3 A2
#define DHTPIN4 A3

#define DHTTYPE DHT11 //tipe DHT

Modbus slave(myId,0,TXEN);  //class untuk id, 0, dan enable untuk RS485 transmitter

DHT dht1(DHTPIN1, DHTTYPE); //class untuk DHT
DHT dht2(DHTPIN2, DHTTYPE);
DHT dht3(DHTPIN3, DHTTYPE);
DHT dht4(DHTPIN4, DHTTYPE);

int valDhtC[4];
int valDhtH[4];
int relayPin[]={10,11,12,13}; // pin relay
int buttonPin[]={4,5,6,7};  //pin tombol

LiquidCrystal_I2C lcd(0x27, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);  // Set the LCD I2C address
char lcdBuff[16];

void setup() 
{
  slave.begin( 19200 ); //komunikasi modbus dengan baudrate 19200
  //Serial.begin(9600);
  pinMode(TXEN, OUTPUT);
  for(int i=0; i<=3; i++)
  {
    pinMode(relayPin[i], OUTPUT);
    pinMode(buttonPin[i], INPUT_PULLUP);
    digitalWrite(relayPin[i], HIGH);
  }
  lcd.begin(16,2);   // initialize the lcd for 16 chars 2 lines, turn on backlight

}

void loop() 
{
  /*
  while(1)
  {
    if(Serial.available())
    {
      char okeOke = Serial.read();
      lcd.setCursor(0,0);
      lcd.print(okeOke);
    }
  }
  */
  readDHT(false); //panggil function readDHT
  int temperature4=0;
  int humidity4=0;
  for(int i=0; i<=3; i++)
  {
    temperature4 += valDhtC[i]; //total 4 sensor
    humidity4 += valDhtH[i];
  }

  int valueTemperature = temperature4/4;  //cari rata2 sensor
  int valueHumidity = humidity4/4;

  lcd.setCursor(0,0); //tampilkan ke lcd
  sprintf(lcdBuff,"ID:%i",myId);
  lcd.print(lcdBuff);
  lcd.setCursor(0,1);
  sprintf(lcdBuff,"Val:%2d %2d %i%i%i",valueTemperature, valueHumidity,digitalRead(relayPin[0]),
                    digitalRead(relayPin[1]),digitalRead(relayPin[2]));
  lcd.print(lcdBuff);
  
  au16data[0] = myId; //simpan nama id ke data yg akan di proses di modbus
  au16data[1] = valueTemperature;//temperature
  au16data[2] = valueHumidity;//humidity
  //au16data[3] = digitalRead(buttonPin[0]);//btn1
  //au16data[4] = digitalRead(buttonPin[1]);//btn2
  //au16data[5] = digitalRead(buttonPin[2]);//btn3
  if(int(au16data[8]) == 1)
  {
    au16data[3] = digitalRead(relayPin[0]);//btn1
    au16data[4] = digitalRead(relayPin[1]);//btn2
    au16data[5] = digitalRead(relayPin[2]);//btn3
  }
    
  slave.poll( au16data, 16 ); //update data dari modbus ke master dan juga membaca data dari master

  if(valueTemperature > int(au16data[6]) && (int(au16data[8]) == 1))
  {
    digitalWrite(relayPin[0], LOW);//kipas ON
    digitalWrite(relayPin[1], HIGH);//lampu OFF
  }
  if(valueTemperature <= int(au16data[6]) && (int(au16data[8]) == 1))
  {
    digitalWrite(relayPin[0], HIGH);
    digitalWrite(relayPin[1], LOW);
  }
  if(valueHumidity > int(au16data[7]) && (int(au16data[8]) == 1))
  {
    digitalWrite(relayPin[2], HIGH);//pump OFF
  }
  if(valueHumidity <= int(au16data[7]) && (int(au16data[8]) == 1))
  {
    digitalWrite(relayPin[2], LOW);
  }
  if(int(au16data[3]) == 1 && (int(au16data[8]) == 0)){digitalWrite(relayPin[0], HIGH);}
  if(int(au16data[3]) == 0 && (int(au16data[8]) == 0)){digitalWrite(relayPin[0], LOW);}
  if(int(au16data[4]) == 1 && (int(au16data[8]) == 0)){digitalWrite(relayPin[1], HIGH);}
  if(int(au16data[4]) == 0 && (int(au16data[8]) == 0)){digitalWrite(relayPin[1], LOW);}
  if(int(au16data[5]) == 1 && (int(au16data[8]) == 0)){digitalWrite(relayPin[2], HIGH);}
  if(int(au16data[5]) == 0 && (int(au16data[8]) == 0)){digitalWrite(relayPin[2], LOW);}

/*
  if(digitalRead(buttonPin[0]) == LOW && (int(au16data[8]) == 0)){digitalWrite(relayPin[0], LOW);}
  if(digitalRead(buttonPin[0]) == HIGH && (int(au16data[8]) == 0)){digitalWrite(relayPin[0], HIGH);}
  if(digitalRead(buttonPin[1]) == LOW && (int(au16data[8]) == 0)){digitalWrite(relayPin[1], LOW);}
  if(digitalRead(buttonPin[1]) == HIGH && (int(au16data[8]) == 0)){digitalWrite(relayPin[1], HIGH);}
  if(digitalRead(buttonPin[2]) == LOW && (int(au16data[8]) == 0)){digitalWrite(relayPin[2], LOW);}
  if(digitalRead(buttonPin[2]) == HIGH && (int(au16data[8]) == 0)){digitalWrite(relayPin[2], HIGH);}  

*/
  lcd.setCursor(6,0);
  sprintf(lcdBuff,"%2d %2d %2d",au16data[6], au16data[7], au16data[8]); //tampilkan nilai ID 
  lcd.print(lcdBuff); 
}
void readDHT(boolean show)  //function baca DHT
{
  valDhtH[0] = dht1.readHumidity();
  valDhtH[1] = dht2.readHumidity();
  valDhtH[2] = dht3.readHumidity();
  valDhtH[3] = dht4.readHumidity();

  valDhtC[0] = dht1.readTemperature();
  valDhtC[1] = dht2.readTemperature();
  valDhtC[2] = dht3.readTemperature();
  valDhtC[3] = dht4.readTemperature();
  if(show)
  {
    lcd.setCursor(0,0);
    sprintf(lcdBuff,"%3d %3d %3d %3d",valDhtH[0],valDhtH[1],valDhtH[2],valDhtH[3]);
    lcd.print(lcdBuff);
    lcd.setCursor(0,1);
    sprintf(lcdBuff,"%3d %3d %3d %3d",valDhtC[0],valDhtC[1],valDhtC[2],valDhtC[3]);
    lcd.print(lcdBuff);
  }
}
