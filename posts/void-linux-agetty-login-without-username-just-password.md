# Void Linux agetty login without username, just password
*Parts of this post were taken from [this Void wiki page](https://wiki.voidlinux.org/Automatic_Login_to_Graphical_Environment). It says that it is deprecated and will eventually be shut down. It also doesn't cover the topic of "asking for password only", but to give credit where credit is due.*

First, recursively copy service files of an already existing tty login service:

```shell
cp -R /etc/sv/agetty-tty1 /etc/sv/agetty-autologin-tty1
```

The new folder name has to end with "ttyX".

Now replace contents of `/etc/sv/agetty-autologin-tty1/conf` with this:

```
GETTY_ARGS="--skip-login --login-options your_username --noclear"
BAUD_RATE=38400
TERM_NAME=linux
```

Now you have to replace the original tty1 service with the new one.

Switch to tty2 with `Ctrl + Alt + F2` and login.  
Disable the regular tty1 service and enable the new service:

```shell
rm /var/service/agetty-tty1
ln -s /etc/sv/agetty-autologin-tty1 /var/service
```

You don't have to reboot. Just switch back to tt1 with `Ctrl + Alt + F1` and it should ask you just for your password.
