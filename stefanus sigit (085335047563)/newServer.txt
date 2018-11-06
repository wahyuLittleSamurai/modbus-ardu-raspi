#!usr/bin/env python
from math import pi,sqrt,acos	#import library

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
instrument = minimalmodbus.Instrument('/dev/ttyUSB0',1) 		#define port serial yg digunakan dan ID slave
instrument2 = minimalmodbus.Instrument('/dev/ttyUSB0',2) 	


instrument.serial.baudrate 					= 19200				#configurasi port serial yg digunakan
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
        for countSlaveId in range(1,3):	#perulangan sebanyak slave yg di tampung
                
                getSlave = urllib.urlencode({'slaveId': countSlaveId})	#parameter ID yg akan dikirim
                readDatabase = urllib.urlopen("http://192.168.3.13/scada/readAllData.php?%s" % getSlave)	#kirimkan ke server web
                responsReadDatabase = readDatabase.read() #baca respon dari server yg mengirimkan nilai dari database yg sudh di simpan

                try:
                        python_obj = json.loads(responsReadDatabase)	#parse ke dalam bentuk JSON
                        print "Data Slave ke:"
                        print python_obj["slave"]	#ambil nilai ID database
                        print "Nilai "
                        print python_obj["suhu"]	#tampilkan nilai suhu
                        print python_obj["spSuhu"]
                        print python_obj["kelembapan"]
                        print python_obj["spKelembapan"]
                        print python_obj["lamp"]
                        print python_obj["fan"]
                        print python_obj["pump"]
                        print "######## end reading JSON ######"

                        
                 
                except (ValueError, KeyError, TypeError):	#jika tidak sesuai dengan format json tampilkan error
                        print "JSON format error"

	if usb2_on == True :
		try:
			print "Registres de l'ID 1 USB"	#baca slave ke 1
			test_reg = instrument2.read_registers(0,10)	#baca register ID Slave 1  dari register 0 - 10
			

                        for ulang in range(3,6):	#ambil nilai lampu, kipas dan pump
                                if test_reg[ulang] == 1:		#jika nilai yg di ambil = 1 maka jadikan variable string true
                                        test_reg[ulang] = "true"
                                else:
                                        test_reg[ulang] = "false"

                        print test_reg       
			params = urllib.urlencode({'slaveId': test_reg[0], 'temp': test_reg[1], 'humi': test_reg[2], 'lamp':test_reg[3], 'fan': test_reg[4], 'pump':test_reg[5]})
                        f = urllib.urlopen("http://192.168.3.13/scada/getFromRaspi.php?%s" % params)	#kirim ke local server
                        responsPHP = f.read()	#baca respons
                        print responsPHP 		#tampilkan respons

                        time.sleep (0.05)	#tunda sebesar 0.05 second

                        instrument2.write_registers(7,9)	#masih belum bisa di pakai untuk write ke slave
                        time.sleep(0.05)
			
		except:
			print ("error USB1 -----------------------")
			time.sleep (1)
		
		
	if usb1_on == True :
		try:
			print "Registres de l'ID 2 USB"
			test_reg = instrument.read_registers(0,10)
			print test_reg
			time.sleep (0.05)
			
		except:
			print ("error usb 2 ------------------------------")
			time.sleep (1)
	
