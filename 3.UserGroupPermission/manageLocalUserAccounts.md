# How to create, delete and modify local user accounts in Linux.
# add new user
```bash
sudo adduser john # after you can add directly info about the user
sudo useradd john
sudo useradd -m jhon # create user and home directory as well.
sudo useradd -m -s /bin/zbash user1 # create user with zbash and home directory
```
# change password
```bash
sudo passwd john
```

# delete and manupilate user account
```bash
sudo deluser john 
sudo userdel john
sudo userdel -r jhon # user's home directory and mail spool delete together.
```

# Some usefull comand using usermod
```bash

sudo usermod -L jhon # without deleting account, effectivly disables the account. -L login.
sudo usermod -U jhon # unlock the account
sudo usermod -e 2028-12-10 jhon # set an account as expired, format date YYYY-MM-DD
sudo usermod -e "" jhon # remove the expiration date

```
# set the password as expired and the password's management
```bash
sudo chage -d 0 jane # the next time jane login. she has to change the password.
sudo chage -d -1 jane # cancel the password expiration
sudo chage -M 30 jane # jane has to change passwd MAXIMUM within 30 days.
sudo chage -M -1 jane # cancel the above setting
sudo chage -l jhon # the crucial info about the password of jhon.

```
# Info about users
```bash
cat /etc/passwd
```
# create system account such as deamon. Deamon ussually use sysacc.
```bash
sudo adduser --system sysacc
```
# login with other account
```bash
sudo usermod -l jane jhon
```

## Local Group and Group Membership

 
```bash
sudo groupadd developers # create a new group
sudo gpasswd -a jhon developers # add jhon to developers group (not primary group)
groups jhon # which groups jhon belongs to
sudo gpasswd -d jhon developers # delete jhon from the group of developers
sudo usermod -g developers jhon # primary group is set from jhon to developers
sudo usermod -aG developers jhon # add jhon developers group. The group is not primary group for jhon.
sudo groupmod -n programers developers # change the group's name 
sudo groupdel programers # delete the group, groupdel: cannot remove the primary group of user 


# I f you want improve your skill on this topic, you should solve the following questions by yourself:

1. Set the jane user account to expire on March 1, 2030.

2. Create a system account called system1

3. Jane's account, i.e., jane, is expired.Unexpire the same and make sure it never expires again.

4. Create a user account called jack with home directory and set its default login shell to be /bin/csh

5. Delete the user account called jack and ensure his home directory is removed.

6. Mark the password for jane as expired to force her to immediately change it the next time she logs in.

7. Add the user jane to the group called developers.

8. Create a group named cricket and set its GID to 9875

9. You already created a group cricket in the previous question. Now, rename this group soccer while preserving the same GID.

10. Create a user sam with UID 5322. Also, make it a member of the soccer group.

11. Update primary group of user sam and set it to rugby

12. Make sure the user jane gets a warning at least 2 days before the password expires. Then check if it is done.



1. sudo usermod -e 2030-03-01 jane
2. sudo useradd --system system1
3. sudo usermod -e "" jane
4. sudo useradd -s /bin/csh -m jack
5. sudo userdel -r jack
6. sudo chage --lastday 0 jane 
sudo chage -d 0 jane
7. sudo usermod -a -G developers jane
8. sudo groupadd --gid 9875 cricket
9. sudo groupmod -n soccer cricket
10. sudo useradd -G soccer sam  --uid 5322 # this is made using only one command
    sudo useradd --uid 5322 sam
    sudo usermod -aG soccer sam
11. sudo usermod -g rugby sam
12. sudo chage -W 2 jane
    sudo chage -l jane








