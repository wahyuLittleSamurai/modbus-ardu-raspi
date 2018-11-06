#!usr/bin/env python
from math import pi,sqrt,acos

import subprocess
import time
import RPi.GPIO as GPIO
import urllib
import httplib
import minimalmodbus
import time
import serial

import urllib
import requests
import os
import json


#cek usb ===>> ls /dev/*USB*
instrument = minimalmodbus.Instrument('/dev/ttyUSB0',1) 	
instrument2 = minimalmodbus.Instrument('/dev/ttyUSB0',2) 	


instrument.serial.baudrate 					= 19200
instrument.serial.bytesize 					= 8
instrument.serial.parity 					= serial.PARITY_NONE
instrument.serial.stopbits 					= 1
instrument.serial.timeout 					= 1                		# secondes
instrument.mode							= minimalmodbus.MODE_RTU 	# rtu ou ascii // MODE_ASCII ou MODE_RTU
instrument.debug 						= False
instrument.serial.xonxoff					= True
instrument.serial.rtscts					= False
instrument.serial.dsrdtr					= False


instrument2.serial.baudrate 				        = 19200
instrument2.serial.bytesize 				        = 8
instrument2.serial.parity 					= serial.PARITY_NONE
instrument2.serial.stopbits 				        = 1
instrument2.serial.timeout 					= 1                		# secondes
instrument2.mode						= minimalmodbus.MODE_RTU 	# rtu ou ascii // MODE_ASCII ou MODE_RTU
instrument2.debug 						= False
instrument2.serial.xonxoff					= True
instrument2.serial.rtscts					= False
instrument2.serial.dsrdtr					= False
minimalmodbus.CLOSE_PORT_AFTER_EACH_CALL	                = True

usb1_on = True
usb2_on = True


if instrument.debug == True:
	print instrument

# Lecture d'un registre
while 1:
       
	if usb2_on == True :
		try:
			print "Registres de l'ID 1 USB"
			test_reg = instrument2.read_registers(0,10)

                        print test_reg
                        
                        time.sleep(0.05)
                        
			
		except:
			print ("error USB1 -----------------------")
			time.sleep (1)
		
		
	if usb1_on == True :
		try:
			
			
			instrument.write_register(0, 450, 10)

                        time.sleep(2)
                        
                        print "read second"
                        print "Registres de l'ID 2 USB"
			test_reg = instrument.read_registers(0,10)
			print test_reg
			time.sleep (0.05)
                        test_reg = instrument.read_registers(0,10)
			print test_reg
			time.sleep (0.05)
			
		except:
			print ("error usb 2 ------------------------------")
			time.sleep (1)
	
