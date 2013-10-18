#!/bin/ash

set -e

[ -z "$CMD" ] && echo "Init command not specified" && exit 2
DAEMON=${CMD%% *}
OPTS=${CMD#* }
[ -z "$NAME" ] && NAME="$DAEMON"
PIDFILE="/var/run/${NAME}.pid"

start() {
    echo -n "Starting $NAME... "
    start-stop-daemon -Smbqp "$PIDFILE" -x "$DAEMON" -- $OPTS
    echo "Done."
}

stop() {
    echo -n "Stopping $NAME... "
    start-stop-daemon -Kqop "$PIDFILE" -x "$DAEMON"
    rm -f "$PIDFILE"
    echo "Done."
}

status() {
    if [ -f "$PIDFILE" ] ; then
        if start-stop-daemon -Ktqp "$PIDFILE" &> /dev/null ; then
            echo "$NAME is running - pid $(cat $PIDFILE)"
            exit 0
        fi
        rm "$PIDFILE"
    fi
    echo "$NAME is not running"
    exit 1
}

case "$1" in
    stop) stop ;;
    start) start ;;
    status) status ;;
    restart) stop ; start ;;
    *) echo "Usage: "$0" {start|stop|status|restart}" ; exit 1
esac
 
exit 0
