#include <ModbusRtu.h>

#define TXEN  2 
#define myId  2
// data array for modbus network sharing
uint16_t au16data[16] = {
  3, 'A', 9265, 4, 2, 7182, 28182, 8, 0, 0, 0, 0, 0, 0, 1, -1 };

/**
 *  Modbus object declaration
 *  u8id : node id = 0 for master, = 1..247 for slave
 *  u8serno : serial port (use 0 for Serial)
 *  u8txenpin : 0 for RS-232 and USB-FTDI 
 *               or any pin number > 1 for RS-485
 */
Modbus slave(myId,0,TXEN); // this is slave @1 and RS-485

void setup() {
  slave.begin( 19200 ); // baud-rate at 19200
  pinMode(TXEN, OUTPUT);
}

void loop() {
  int randomTF = random(1,10)%2;
  
  
  au16data[0] = myId;
  au16data[1] = analogRead(A0);//temperature
  au16data[2] = analogRead(A1);//humidity
  au16data[3] = randomTF;//lamp
  au16data[4] = randomTF;//fan
  au16data[5] = randomTF;//pump
  slave.poll( au16data, 16 );
 
}
