#!/bin/ash

case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  restart|reload)
  	stop
  	start
	;;
  *)
	echo "Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $?
