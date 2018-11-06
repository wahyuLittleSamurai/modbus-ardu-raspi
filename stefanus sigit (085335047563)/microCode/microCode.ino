#include <LiquidCrystal.h>
#include "DHT.h"

#define DHTPIN1 0
#define DHTPIN2 1
#define DHTPIN3 2
#define DHTPIN4 3

#define lcdCon  15

#define DHTTYPE DHT11

#define SSerialTxControl 10   //RS485 Direction control

#define RS485Transmit    HIGH
#define RS485Receive     LOW

DHT dht1(DHTPIN1, DHTTYPE);
DHT dht2(DHTPIN2, DHTTYPE);
DHT dht3(DHTPIN3, DHTTYPE);
DHT dht4(DHTPIN4, DHTTYPE);

char lcdBuff[16];

LiquidCrystal lcd(A7, A6, A5, A4, A3, A2 );
int relayPin[]={4,5,6,7};

int valDhtC[4];
int valDhtH[4];
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  
  lcd.begin(16,2);
  dht1.begin();dht2.begin();dht3.begin();dht4.begin();
  pinMode(lcdCon, OUTPUT);
  for(int i=0; i<=3; i++)
  {
    pinMode(relayPin[i], OUTPUT);
    digitalWrite(relayPin[i], HIGH);
  }
  analogWrite(lcdCon, 100);

  pinMode(A0, OUTPUT);
  digitalWrite(A0, HIGH);
  
  pinMode(SSerialTxControl, OUTPUT);    
  digitalWrite(SSerialTxControl, RS485Receive);
}
char byteSend;
int counterKirim=0;
void loop() {
  counterKirim++;
  Serial.println(counterKirim);
  delay(500);
  //lcd.setCursor(0,0);
  //lcd.print("oke");
  //readDHT(true);
  /*
  if (Serial.available()) 
  {
    byteSend = Serial.read();   // Read the byte 
    
    digitalWrite(A0, LOW);  // Show activity
    delay(10);              
    digitalWrite(A0, HIGH);   
    
    digitalWrite(SSerialTxControl, RS485Transmit);  // Enable RS485 Transmit    
    Serial.println("ok"); // Send the byte back
    delay(10); 
   
    digitalWrite(SSerialTxControl, RS485Receive);  // Disable RS485 Transmit      
//    delay(100);
  }// End If RS485SerialAvailable
  */
}
void readDHT(boolean show)
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

