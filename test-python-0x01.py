#!/bin/python

"""System module."""
import os
from icmplib import ping
from colorama import Fore


a_hosts = []

def clear_console():
    """clear console"""
    if os.name in ("nt", "dos"):
        clear_command = "cls"
    else:
        clear_command = "clear"
    os.system(clear_command)


def start_page():
    """ main starting function"""
    vchoos = input("Choose an option\n1.See all Hosts\n2.Add new Host\n3.Start script\n")
    clear_console()
    if vchoos == "1":
        p_hosts()
        start_page()
    elif vchoos == "2":
        a_host()
    elif vchoos == "3":
        st_script()
    else:
        print("Not an option, try again")
        start_page()


def a_host():
    """ adding hosts"""
    ad_host = input("please enter new hosts ip/domain or B to back to main list:\n")
    clear_console()
    if ad_host in ("B", "b"):
        start_page()
    elif ad_host in ("", " "):
        a_host()
    else:
        a_hosts.append(ad_host)
        a_host()


def p_hosts():
    """ printing hosts"""
    clear_console()
    for i in a_hosts:
        print(i + "\n")


def st_script():
    """ pinging hosts"""
    while True:
        for i in a_hosts:
            p_hosts = ping(i, interval=0.001, timeout=0.1)
            if p_hosts.is_alive is True:
                print(Fore.GREEN + p_hosts.address + " is up")
            else:
                print(Fore.RED + p_hosts.address + " is down")

if __name__ == "__main__":
    clear_console()
    start_page()
