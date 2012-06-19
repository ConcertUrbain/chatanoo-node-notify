#!/bin/bash
rsync -avz --delete -e ssh . "root@ns368978.ovh.net:/var/www/vhosts/dring93.org/node/notify" --exclude-from 'rsync.exclude'