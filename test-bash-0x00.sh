#!/bin/bash

# checking for ether apt or pacman

dp_Check () {
  if ! command -v pacman &> /dev/null
  then
    if ! command -v apt &> /dev/null
    then
      clear
      echo  "this distro is not supported"
      exit
    else
      deb_Pack
    fi
  else
  arch_Pack
  fi
  }

# making package manager ready

deb_Pack () {
  dis="U"
  sudo apt update &> /dev/null
  ins_Pack="sudo apt install -y"
  lol_Cat
}

arch_Pack () {
  dis="A"
  sudo pacman --noconfirm -Syu &> /dev/null
	ins_Pack="sudo pacman --noconfirm -S"
  lol_Cat
}

#lolcat

lol_Cat () {
  if ! command -v lolcat &> /dev/null
  then
    $ins_Pack lolcat &>/dev/null
  else
    ban_Check
  fi
}

# banner

ban_Check () {
  $ins_Pack lolcat &>/dev/null
  echo "
#####################################
##   /\ /\          Telegram:      ##
##  < *-* >__|      @Not_Unique    ##
##    / /--//                      ##
#####################################
" | lolcat
  de_Check
}

# post DE

de_Check (){
  p_Test=""
  echo "do you want to install new DE ?(yes/no)"
  read de_A
  if [ "$de_A" == "yes" ];
  then
    de_Run
  elif [ "$de_A" == "no" ];
  then
    junk_Run
  else
    clear
    echo "input is case sensitive"
    ban_Check
  fi
}

# post DE install (xorg/lightdm)

de_Run () {
  clear
  p_Test="${ldm} ${nmg}"
  if [ "$dis" == "A" ];
  then
    p_Test="${p_Test[@]} ${arch_Xorg[@]}"
    usr_De
  else
    p_Test="${p_Test[@]} ${deb_Xorg[@]}"
    usr_De
  fi
}

# DE installer

usr_De () {
  cho_De="choose your DE(1/2/3):\n1.KDE\n2.Cinnamon\n3.Back"
  echo -e $cho_De
  read de_No
  if [ "$de_No" == "1" ];
  then
    if [ "$dis" == "A" ];
    then
      p_Test="${p_Test[@]} ${arch_Kde[@]}"
      junk_Run
    else
      p_Test="${p_Test[@]} ${deb_Kde[@]}"
      junk_Run
    fi
  elif  [ "$de_No" == "2" ];
  then
    if [ "$dis" == "A" ];
    then
      p_Test="${p_Test[@]} ${arch_Cin[@]}"
      junk_Run
    else
      p_Test="${p_Test[@]} ${deb_Cin[@]}"
      junk_Run
    fi
  elif  [ "$de_No" == "3" ];
  then
    clear
    de_Check
  else
    clear
    echo "pleas choose a DE from list"
    usr_De
  fi
}

# junk installer

junk_Run () {
  clear
  echo -e "these are some junk apps, you can add more by editing script \ndo you want to install them ?(yes/no)"
  read an_Ju
  if [ "$an_Ju" == "yes" ];
  then
    if [ "$dis" == "A" ];
    then
      p_Test="${p_Test[@]} ${junk_Arch[@]}"
      a_Install
    else
      p_Test="${p_Test[@]} ${junk_Deb[@]}"
      a_Install
    fi
  elif [ "$an_Ju" == "no" ];
  then
    clear
    exit
  else
    clear
    echo "input is case sensitive"
    junk_Run
  fi
}

a_Install () {
  clear
  for i in ${p_Test[@]} ; do
  echo "$i is installing"
  i_Test="$ins_Pack $i"
  $i_Test &> /dev/null
  echo "$i is done"
  done
}

# packages

deb_Xorg=("xorg")
arch_Xorg=("xorg" "xorg-server")
ldm=("lightdm")
nmg=("NetworkManager" "net-tools")

deb_Kde=("kde-full")
arch_Kde=("plasma" "kde-applications")

deb_Cin=("cinnamon-desktop-environment")
arch_Cin=("cinnamon" "gnome-terminal")

deb_Libo=("libreoffice")
arch_Libo=("libreoffice-fresh")

# junk packages

junk_Deb=("nmap" "iftop" "nload" "bpytop" "netcat")
junk_Arch=("nmap" "iftop" "nload" "bpytop" "gnu-netcat")

clear
dp_Check
