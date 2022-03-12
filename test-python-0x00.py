#!/bin/python

#ping python script

from icmplib import ping

#all hosts
a_hosts = []

# main starting function
def start_page():
    vchoos = input("Choose an option\n1.See all Hosts\n2.Add new Host\n3.Start script\n")
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

# adding hosts
def a_host():
    ad_host = input("please enter new hosts ip/domain and B ti back to main list:\n")
    a_hosts.append(ad_host)
    start_page()

# printing hosts
def p_hosts():
    for i in a_hosts:
        print(i)

# pinging hosts
def st_script():
    while True:
        for i in a_hosts:
            p_hosts = ping(i)
            if p_hosts.is_alive is True:
                print(p_hosts.address + " is up")
            else:
                print(p_hosts.address + " is down")


start_page()
