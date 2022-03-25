#!/bin/python

import os
import requests
import icmplib
from os.path import exists
from icmplib import ping


def main():
    syscheck()
    clear()
    lhost()
    list()
    test()

def syscheck():
    if os.name in ("nt", "dos"):
        quit()
    else:
        return

def clear():
    os.system("clear")

def lhost():
    global thost
    thost = input("Enter host with http/https\nHost:")
    if thost[:6] in ("http:/", "https:"):
        if ping(thost).is_alive == True or requests.get(thost).status_code == 200:
            if thost[1:] == "/":
                return
            else:
                 thost = thost + "/"
                 return
        else:
            clear()
            print("Host is down, make sure its alive before scan")
            lhost()
    else:
        clear()
        print("Make sure host is valid, dont forget http/https")
        lhost()

def list():
    global wlist
    wlist = input("Please enter path to your directory.txt\nPath:")
    if exists(wlist) == True:
        clear()
        return
    else:
        clear()
        print("Invalid Path")
        list()

def test():
    file = open(wlist, 'r')
    for i in file:
        if requests.get(thost).status_code == 200:
            print( thost + i + "is up")
        else:
            print( thost + i + "is down")

if __name__ == '__main__':
    main()
