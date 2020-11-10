## Create Service

```
$ cat /lib/systemd/system/runscript.service

[Unit]
Description=My Script Service
After=multi-user.target

[Service]
Type=idle
ExecStart=/usr/bin/start_script.sh

[Install]
WantedBy=multi-user.target


/usr/bin/start_script.sh
chmod u+x /usr/bin/start_script.sh
chmod 644 /lib/systemd/system/runscript.service
sudo systemctl enable runscript.service
```

## Crontab
```
$ sudo crontab -e
|- #
|- # For more information see the manual pages of crontab(5) and cron(8)
|- #
|- # m h  dom mon dow   command
|- @reboot /root/script.sh
|
```

## update-rc.d
```
$ chmod 777 /path_to_script/script.sh
$ sudo cp /path_to_script/script.sh /etc/init.d/
$ sudo update-rc.d script.sh defaults

```

__delete from update-rc.d__:

```
$ sudo rm /etc/init.d/script.sh
$ sudo update-rc.d script.sh remove

```

## .bashrc and .profile

```
$ echo "sh script.sh" >>  ~/.profile  or  echo "sh script.sh" >> ~/.bash_profile
```

## supervisor
```
$ apt-get install supervisor -y
$ service supervisor start
$ cat /etc/supervisor/conf.d/worker.conf

[program:worker]
command=/usr/bin/php /var/www/worker.php
stdout_logfile=/var/log/worker.log
autostart=true
autorestart=true
user=www-data
stopsignal=KILL
numprocs=1

$ supervisorctl reread
$ supervisorctl update
```
