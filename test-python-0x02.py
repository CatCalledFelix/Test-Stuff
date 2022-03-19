#System modules
import sys
import os
import psutil
import socket
import shutil

#Importing modules in lib directory and font
picdir = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'pic')
libdir = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'lib')
if os.path.exists(libdir):
    sys.path.append(libdir)

#Other general python modules
import logging
import time
import traceback

#GPIO and display modules
from waveshare_epd import epd2in13_V2
from PIL import Image,ImageDraw,ImageFont

#Open font file and set a size
font10 = ImageFont.truetype(os.path.join(picdir, 'Font.ttc'), 10)
#font24 = ImageFont.truetype(os.path.join(picdir, 'Font.ttc'), 24)

epd = epd2in13_V2.EPD() #Setting up display model
image = Image.new('1', (epd.height, epd.width), 255) #Making dosplay ready to print img
draw = ImageDraw.Draw(image) #Making dosplay ready to print txt

#Image
def gimg():
    img = Image.open('test.bmp')
    image.paste(img, (2,2))

#Header
def head():
    draw.text((105, 0), os.getlogin() + "@" + socket.gethostname(), font = font10, fill = 0)

#CPU Usage
def uscpu():
    draw.text((105, 10),"CPU Usage: " + str(psutil.cpu_percent()) + "% (" + str(psutil.cpu_count()) + ")", font = font10, fill = 0)

#Memory Usage
def mem():
    draw.text((105, 20),"RAM Usage: " + str(psutil.virtual_memory()[2]) + "% " + str(round(int(psutil.virtual_memory()[3]) /  1000000)) + "/" + str(round(int(psutil.virtual_memory()[0]) / 1000000)) + " MB", font = font10, fill = 0)

#Disc usage
def disk():
    draw.text((105, 30),"Disk Usage: " + str(psutil.disk_usage("/")[3]) + "% " + str(round(int(psutil.disk_usage("/")[1]) /  1000000000)) + "/" + str(round(int(psutil.disk_usage("/")[0]) / 1000000000)) + " GB", font = font10, fill = 0)

#Real time
def clock():
    draw.text((105, 40),"It is " + time.strftime('%H:%M:%S'), font = font10, fill = 0)

#Display final
def display():
    epd.init(epd.FULL_UPDATE)
    epd.display(epd.getbuffer(image))

#Partial display
def pdisplay():
    epd.init(epd.PART_UPDATE)
    epd.displayPartial(epd.getbuffer(image))

#Sleepfor i seconds
def dleep():
    time.sleep(900)

#Screen Reset
def clean():
    epd.init(epd.FULL_UPDATE)
    epd.Clear(0xFF)

#Main
def main():
    clean()
    gimg()
    head()
    display()
    while True:
        uscpu()
        mem()
        disk()
        clock()
        pdisplay()
        dleep()
    
    
if __name__ == "__main__":
    main()
