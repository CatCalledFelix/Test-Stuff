#!/bin/bash

# crappy nmap, test


clear
n_Check () {
  if ! command -v nmap &> /dev/null
  then
    clear
    echo "nmap is not installed or in PATH"
    exit
  else
    banner_Me
  fi
}

banner_Me () {
  n_rdy
}

n_rdy () {
  echo "This script is using nmap, make sure Hosts/Ranges/Subnets are vaid and available first"
  echo "1.Single Host/Range/Subnet"
  echo "2.List of Hosts/Ranges/Subnets(file-path)"
  read t_No
  if [ "$t_No" == "1" ];
  then
    s_Host
  elif [ "$t_No" == "2" ];
  then
    m_Host
  else
    clear
    echo "Please choose from below list (1/2)"
    n_rdy
  fi
}

s_Host () {
  clear
  echo "Enter Host/Subnet/Range"
  read t_M
  t_S="$t_M"
  clear
  n_Opt
}

m_Host () {
  clear
  echo "Enter Path of file containing Hosts/Ranges/Subnets"
  read t_M
  t_S="$m_Host $t_M"
  clear
  n_Opt
}


n_Opt () {
  echo -e "Your target is $t_M \nChoose and option from the list"
  echo "1.Change Target"
  echo "2.Port Options"
  echo "3.Scan Technique"
  echo "4.Service/Version Detection"
  echo "5.Script Scan"
  echo "x.Start Scan"
  read opt_Cho
  if [ "$opt_Cho" == "1" ];
  then
    clear
    n_rdy
  elif [ "$opt_Cho" == "2" ];
  then
    clear
    port_Opt
  elif [ "$opt_Cho" == "3" ];
  then
    clear
    tech_Opt
  elif [ "$opt_Cho" == "4" ];
  then
    clear
    det_Sv
  elif [ "$opt_Cho" == "5" ];
  then
    clear
    scr_Scan
  elif [ "$opt_Cho" == "x" ];
  then
    clear
    com_Run="$n_com $com_Final $t_S"
    f_Stage
  else
    echo "Please choose from below list (1/2/3/4/5)"
    n_Opt
  fi
}

port_Opt () {
  echo "Port Scan Options"
  echo "1.Specific Port/Ports/Range"
  echo "2.Fast Port Scan (fewer ports)"
  echo "3.Full Port Scan"
  echo "4.Back"
  read p_Optr
  if [ "$p_Optr" == "1" ];
  then
    com_Final="$s_P"
    clear
    n_Opt
  elif [ "$p_Optr" == "2" ];
  then
    com_Final="$f_P"
    clear
    n_Opt
  elif [ "$p_Optr" == "3" ];
  then
    com_Final="$a_P"
    clear
    n_Opt
  elif [ "$p_Optr" == "4" ];
  then
    clear
    n_Opt
  else
    echo "Please choose from below list (1/2/3/4)"
    port_Opt
  fi
}

tech_Opt () {
  echo "Scan Technique Options"
  echo "1.SYN Scan"
  echo "2.ACK Scan"
  echo "3.Window Scan"
  echo "4.Maimon Scan"
  echo "5.UDP Scan"
  echo "6.Xmas Scan"
  echo "7.Back"
  read t_Scan
  if [ "$t_Scan" == "1" ];
  then
    com_Final="$com_Final $s_S"
    clear
    n_Opt
  elif [ "$t_Scan" == "2" ];
  then
    com_Final="$com_Final $a_S"
    clear
    n_Opt
  elif [ "$t_Scan" == "3" ];
  then
    com_Final="$com_Final $w_S"
    clear
    n_Opt
  elif [ "$t_Scan" == "4" ];
  then
    com_Final="$com_Final $m_S"
    clear
    n_Opt
  elif [ "$t_Scan" == "5" ];
  then
    com_Final="$com_Final $u_S"
    clear
    n_Opt
  elif [ "$t_Scan" == "6" ];
  then
    com_Final="$com_Final $x_S"
    clear
    n_Opt
  elif [ "$t_Scan" == "7" ];
  then
    n_Opt
  else
    echo "Please choose from below list (1/2/3/4/5/6/7)"
  fi
}

det_Sv () {
  com_Final="$com_Final $d_Sv"
  clear
  n_Opt
}

scr_Scan () {
  com_Final="$com_Final $s_Script"
  clear
  n_Opt
}

f_Stage () {
  echo -e "Scan starts in 10 seconds.\nTarget:$t_M\nCommand:$com_Final"
  sleep 10
  $com_Run
}


n_com="nmap"
m_Host="-iL"

s_P="-p"
f_P="-F"
a_P="-p-"

m_S="-sM"
w_S="-sW"
a_S="-sA"
s_S="-sS"
u_S="-sU"
x_S="-sX"

d_Sv="-sV"

s_Script="-sC"


n_Check
