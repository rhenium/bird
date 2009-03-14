#! /bin/sh
### BEGIN INIT INFO
# Provides:          bird
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/sbin/bird

test -f $DAEMON || exit 0

case "$1" in
  start)
	echo -n "Starting BIRD - Internet routing daemon: "
	echo quit | birdc >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo already running
	else
		$DAEMON
		if [ $? -gt 0 ]; then
			echo failed
		else
			echo ok
		fi
	fi
	;;
  stop)
	echo -n "Stopping BIRD - Internet routing daemon: "
	echo down | /usr/sbin/birdc >/dev/null 
	;;
  reload)
  	echo -n "Reloading BIRD"
	echo configure | birdc >/dev/null
	echo 
  	;;
  restart|force-reload)
  	echo -n "Stopping BIRD - Internet routing daemon: "
	echo down | /usr/sbin/birdc >/dev/null
	echo -n "Starting BIRD - Internet routing daemon: "
	$DAEMON
	if [ $? -gt 0 ]; then
		echo failed
	else
		echo ok
	fi
	;;
  *)
	echo "Usage: bird {start|stop|reload|restart|force-reload}" >&2
	exit 1
	;;
esac

exit 0
