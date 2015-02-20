#!/bin/bash

set -e

# refer <https://github.com/angular/protractor/blob/master/scripts/sauce_connect_setup.sh>

CONNECT_URL="https://saucelabs.com/downloads/sc-latest-linux.tar.gz"
CONNECT_DIR="/tmp/sauce-connect-$RANDOM"
CONNECT_DOWNLOAD="sc-latest-linux.tar.gz"

CONNECT_LOG="$LOGS_DIR/sauce-connect"
CONNECT_STDOUT="$LOGS_DIR/sauce-connect.stdout"
CONNECT_STDERR="$LOGS_DIR/sauce-connect.stderr"

# Get Connect and start it
mkdir -p $CONNECT_DIR
cd $CONNECT_DIR
curl $CONNECT_URL -o $CONNECT_DOWNLOAD 2> /dev/null 1> /dev/null
mkdir sauce-connect
tar --extract --file=$CONNECT_DOWNLOAD --strip-components=1 --directory=sauce-connect > /dev/null
rm $CONNECT_DOWNLOAD

SAUCE_ACCESS_KEY=`echo $SAUCE_ACCESS_KEY | rev`


ARGS=""

# Set tunnel-id only on Travis, to make local testing easier.
if [ ! -z "$TRAVIS_JOB_NUMBER" ]; then
  ARGS="$ARGS --tunnel-identifier $TRAVIS_JOB_NUMBER"
fi
if [ ! -z "$BROWSER_PROVIDER_READY_FILE" ]; then
  ARGS="$ARGS --readyfile $BROWSER_PROVIDER_READY_FILE"
fi


echo "Starting Sauce Connect in the background, logging into:"
echo "  $CONNECT_LOG"
echo "  $CONNECT_STDOUT"
echo "  $CONNECT_STDERR"
sauce-connect/bin/sc -u $SAUCE_USERNAME -k $SAUCE_ACCESS_KEY -v $ARGS \
  --logfile $CONNECT_LOG 2> $CONNECT_STDERR 1> $CONNECT_STDOUT &
