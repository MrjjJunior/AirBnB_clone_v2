#!/usr/bin/python3 
''' Fabric script generates a .tgz archive from the contents of the web_static  '''
from fabric.api import local
from datetime import datetime
import os

def do_pack():
    '''  '''
    try:
        now = datetime.now()
        timestamp = now.strftime("%Y%m%d%H%M%S")
        local("mkdir -p versions")
        filename = "versions/web_static_{}.tgz".format(timestamp)
        local("tar -cvzf {} web_static".format(filename))
        return filename
    except:
        return None
