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
	
if instrument2.debug == True:
	print instrument2

# Lecture d'un registre
while 1:
        
	if usb2_on == True :
		try:
                        getSlave = urllib.urlencode({'slaveId': 2})
                        readDatabase = urllib.urlopen("http://192.168.3.13/scada/readAllData.php?%s" % getSlave) #ip server diganti
                        responsReadDatabase = readDatabase.read()

                        try:
                                python_obj = json.loads(responsReadDatabase)
                                print "Data Slave ke:"
                                print python_obj["slave"]
                                print "Nilai "
                                print python_obj["suhu"]
                                print python_obj["spSuhu"]
                                print python_obj["kelembapan"]
                                print python_obj["spKelembapan"]
                                print python_obj["lamp"]
                                print python_obj["fan"]
                                print python_obj["pump"]
                                print python_obj["mode"]
                                print "######## end reading JSON ######"

                                
                         
                        except (ValueError, KeyError, TypeError):
                                print "JSON format error"

                        spSuhu = int(python_obj["spSuhu"])
                        spKelembapan = int(python_obj["spKelembapan"])
                        
                        if python_obj["mode"] == "true":
                                myMode = 1
                        else:
                                myMode = 0
                        
                        instrument2.write_register(6, spSuhu, 0, 16, False)
                        time.sleep(0.5)
                        
                        print "Done Write Register"
                        
			print "Registres de l'ID 1 USB"
			test_reg = instrument2.read_registers(0,10)
			

                        for ulang in range(3,6):
                                if test_reg[ulang] == 1:
                                        test_reg[ulang] = "true"
                                else:
                                        test_reg[ulang] = "false"
                        if test_reg[8] == 1:
                                test_reg[8]="true"
                        else:
                                test_reg[8] = "false"

                        print test_reg       
			params = urllib.urlencode({'slaveId': test_reg[0], 'temp': test_reg[1], 'humi': test_reg[2], 'lamp':test_reg[3], 'fan': test_reg[4], 'pump':test_reg[5], 'mode':test_reg[8]})
                        f = urllib.urlopen("http://192.168.3.13/scada/getFromRaspi.php?%s" % params) #ip server di ganti
                        responsPHP = f.read()
                        print responsPHP 

                        time.sleep (0.05)

                        instrument2.write_register(7, spKelembapan, 0, 16, False)
                        time.sleep(0.5)
                        print "Done Write Register 2"

                        instrument2.write_register(8, myMode, 0, 16, False)
                        time.sleep(0.5)
                        print "Done Write Register 3"

                        if python_obj["lamp"] == "true":
                                valLamp = 1
                        else:
                                valLamp = 0
                        if python_obj["fan"] == "true":
                                valFan = 1
                        else:
                                valFan = 0
                        if python_obj["pump"] == "true":
                                valPump = 1
                        else:
                                valPump = 0
                        
                        instrument2.write_register(3, valLamp, 0, 16, False) #manual relay 1
                        time.sleep(0.5)
                        print "Done Write Register 4"
                        instrument2.write_register(4, valFan, 0, 16, False) #manual relay 1
                        time.sleep(0.5)
                        print "Done Write Register 5"
                        instrument2.write_register(5, valPump, 0, 16, False) #manual relay 1
                        time.sleep(0.5)
                        print "Done Write Register 6"
			
		except:
			print ("error USB1 -----------------------")
			time.sleep (1)
		
		
	if usb1_on == True :
		try:
                        getSlave = urllib.urlencode({'slaveId': 1})
                        readDatabase = urllib.urlopen("http://192.168.3.13/scada/readAllData.php?%s" % getSlave) #ip server di ganti
                        responsReadDatabase = readDatabase.read()

                        try:
                                python_obj = json.loads(responsReadDatabase)
                                print "Data Slave ke:"
                                print python_obj["slave"]
                                print "Nilai "
                                print python_obj["suhu"]
                                print python_obj["spSuhu"]
                                print python_obj["kelembapan"]
                                print python_obj["spKelembapan"]
                                print python_obj["lamp"]
                                print python_obj["fan"]
                                print python_obj["pump"]
                                print python_obj["mode"]
                                print "######## end reading JSON ######"

                                
                         
                        except (ValueError, KeyError, TypeError):
                                print "JSON format error"

                        spSuhu = int(python_obj["spSuhu"])
                        spKelembapan = int(python_obj["spKelembapan"])
                        
                        if python_obj["mode"] == "true":
                                myMode = 1
                        else:
                                myMode = 0
                        
                        instrument.write_register(6, spSuhu, 0, 16, False)
                        time.sleep(0.5)
                        
                        print "Done Write Register"
                                
			print "Registres de l'ID 2 USB"
			test_reg = instrument.read_registers(0,10)

			for ulang in range(3,6):
                                if test_reg[ulang] == 1:
                                        test_reg[ulang] = "true"
                                else:
                                        test_reg[ulang] = "false"
                        if test_reg[8] == 1:
                                test_reg[8]="true"
                        else:
                                test_reg[8] = "false"

                        print test_reg
                        params = urllib.urlencode({'slaveId': test_reg[0], 'temp': test_reg[1], 'humi': test_reg[2], 'lamp':test_reg[3], 'fan': test_reg[4], 'pump':test_reg[5], 'mode':test_reg[8]})
                        f = urllib.urlopen("http://192.168.3.13/scada/getFromRaspi.php?%s" % params) #ip server di ganti
                        responsPHP = f.read()
                        print responsPHP 

                        time.sleep (0.05)

                        instrument.write_register(7, spKelembapan, 0, 16, False)
                        time.sleep(0.5)
                        print "Done Write Register 2"

                        instrument.write_register(8, myMode, 0, 16, False)
                        time.sleep(0.5)
                        print "Done Write Register 3"

                        if python_obj["lamp"] == "true":
                                valLamp = 1
                        else:
                                valLamp = 0
                        if python_obj["fan"] == "true":
                                valFan = 1
                        else:
                                valFan = 0
                        if python_obj["pump"] == "true":
                                valPump = 1
                        else:
                                valPump = 0
                        
                        instrument.write_register(3, valLamp, 0, 16, False) #manual relay 1
                        time.sleep(0.5)
                        print "Done Write Register 4"
                        instrument.write_register(4, valFan, 0, 16, False) #manual relay 1
                        time.sleep(0.5)
                        print "Done Write Register 5"
                        instrument.write_register(5, valPump, 0, 16, False) #manual relay 1
                        time.sleep(0.5)
                        print "Done Write Register 6"
			
		except:
			print ("error usb 2 ------------------------------")
			time.sleep (1)
	
