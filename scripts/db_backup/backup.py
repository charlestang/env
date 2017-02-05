#!/usr/bin/python
#coding:utf-8

import sys
import os
from yaml import load
from datetime import datetime
import dropbox
from dropbox.files import WriteMode
from dropbox.exceptions import ApiError, AuthError

if len(sys.argv) < 2:
    print >>sys.stderr, "Usage: %s <config_file>" % sys.argv[0]
    sys.exit(0)

conf = load(file(sys.argv[1], 'r'))

# config file is a YAML looks like
# ---
# server-name: 127.0.0.1
# local-backup-path: /tmp
# remote-backup-path: /backup
# dropbox-token: jdkgjdkjg
# databases:
#   - host:    localhost
#     port:    3306
#     user:    user
#     pass:    password
#     name:    database1
#     charset: utf8
#   - host:    localhost
#     port:    3306
#     user:    user2
#     pass:    password2
#     name:    database2
#     charset: utf8

for db in conf['databases'] :
    filename = "%s_%s.sql" % (db['name'], datetime.now().strftime("%Y%m%d-%H-%M-%S")) 
    filepath = "%s/%s" % (conf['local-backup-path'], filename)
    cmd = "mysqldump -h%s -u%s -p%s -P%s --single-transaction %s > %s" % (
            db['host'],
            db['user'], 
            db['pass'], 
            db['port'], 
            db['name'], 
            filepath
            )
    os.system(cmd)
    cmd = "gzip %s" % filepath
    os.system(cmd)
    filepath = filepath + '.gz'
    dbx = dropbox.Dropbox(conf['dropbox-token'])
    backuppath = "%s/%s/%s/%s" % (
            conf['remote-backup-path'],        # remote path
            datetime.now().strftime("%Y%m%d"), # date string
            conf['server-name'],               # server name
            filename + '.gz')
    with open(filepath, 'rb') as f:
        time = datetime.now().strftime("%Y-%m-%d %H:%M:%S ")
        print(time + "Uploading " + filepath + " to Dropbox as " + backuppath)
        try:
            dbx.files_upload(f.read(), backuppath, mode=WriteMode('overwrite'))
        except ApiError as err:
            # This checks for the specific error where a user doesn't have
            # enough Dropbox space quota to upload this file
            if (err.error.is_path() and
                    err.error.get_path().error.is_insufficient_space()):
                sys.exit("ERROR: Cannot back up; insufficient space.")
            elif err.user_message_text:
                print(err.user_message_text)
                sys.exit()
            else:
                print(err)
                sys.exit()

