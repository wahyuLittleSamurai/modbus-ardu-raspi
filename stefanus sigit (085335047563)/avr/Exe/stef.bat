@echo off
avrdude -c usbasp -P usb -p m16 -U flash:w:stef.hex
pause
