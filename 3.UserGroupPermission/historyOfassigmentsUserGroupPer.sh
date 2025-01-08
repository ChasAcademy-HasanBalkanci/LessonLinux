1  history
    2  clear
    3  sudo useradd -m alice
    4  sudo useradd -m bob charlie 
    5  sudo useradd -m bob 
    6  clear
    7  sudo useradd -m charlie
    8  sudo useradd -m david
    9  sudo useradd -m evert
   10  tail /etc/passwd
   11  cd
   12  ls
   13  cd ~
   14  ls -lh
   15  cd /home
   16  ls
   17  sudo groupadd developers
   18  sudo -aG developers alice
   19  sudo usermod -aG developers alice
   20  sudo usermod -aG developers charlie
   21  sudo usermod -aG developers evert
   22  sudo mkdir /opt/developers
   23  sudo chgrp developers /opt/developers/
   24  sudo chmod 2770 /opt/developers/
   25  sudo -e 2024-12-31 bob
   26  echo $EDITOR
   27  sudo -e 2024-12-31 bob
   28  vim --version
   29  cd
   30  vim --version
   31  sudo apt install vim -y
   32  clear
   33  man usermod | grep expiration
   34  apropos "expiration"
   35  man expiry
   36  man usermod
   37  man usermod | grep expiredate
   38  sudo -e 2024-12-31 bob
   39  sudo usermod -e 2024-12-31 bob
   40  sudo usermod -e 2024-12-31 david
   41  man usermod | grep expiredate
   42  man usermod -e
   43  apropos "password"
   44  apropos "password" | grep force
   45  man passwd | less
   46  sudo passwd -e evert
   47  su evert
   48  passwd evert
   49  sudo passwd evert
   50  su evert
   51  history >> assigmetn_user_group_permision.txt
   52  ls
   53  cat ass
   54  cat assigmetn_user_group_permision.txt
   55  clear
   56  ls /opt/developers/
   57  su bob
   58  sudo passwd bob
   59  su bob
   60  su alice
   61  sudo passwd alice
   62  su alice
   63  history > assigmetn_user_group_permision.txt