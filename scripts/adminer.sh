#!/usr/bin/env bash

if [[ -z $1 ]]; then
    OUTPUT="/vagrant/adminer.php"
else
    OUTPUT="$1/adminer.php"
fi

curl -s -o $OUTPUT -L "http://www.adminer.org/latest-mysql-en.php" \
  && printf "Downloaded Adminer successfully\n" \
  || (printf "Error downloading Adminer\n" && exit 1)
