#!/usr/bin/python3
'''
script that generates a .tgz archive from
contents of the web_static folder
'''
from datetime import datetime
from fabric.api import local
import os


def do_pack():
    ''' generates a .tgz archive '''
    # creating versions dir
    if not os.path.exists("versions"):
        os.makedirs("versions")

    # getting the time
    time = datetime.now()
    date = time.strtime("%Y%m%d%H%M%s")

    # creating name of the archive
    archive_name = "web_static_{}.tgz".format(date)
    archive_path = "versions/{}".format(archive_name)

    # creating archive
    try:
        local("tar -cvzf {} web_static".format(archive_path))
        return archive_path
    except Exception:
        return None
