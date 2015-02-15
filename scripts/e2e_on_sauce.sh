#!/bin/bash

SAUCE_ACCESS_KEY=`echo $SAUCE_ACCESS_KEY | rev`

node_modules/gulp/bin/gulp.js run-e2e --nosound
node_modules/gulp/bin/gulp.js run-e2e --nosound --prod
