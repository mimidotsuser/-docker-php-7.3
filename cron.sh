#!/bin/sh
set -eu

logfile="/app/cron/t.log" &&
  cd /app/cron &&
  touch $logfile &&
  echo "* * * * * /usr/local/bin/php /var/www/html/artisan schedule:run > $logfile  2>&1" >>tempcron &&
  /usr/sbin/crond &&
  crontab tempcron &&
  rm tempcron &&
  tail -f $logfile