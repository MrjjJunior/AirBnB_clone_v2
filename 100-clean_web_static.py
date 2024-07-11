#!/user/bin/python3
'''
Script that deletes out of date archives
'''
from fabric.api import *
import os

env.hosts = ['<IP web-01>', '<IP web-02>']

def do_clean(number=0):
    """Delete out-of-date archives."""
    number = int(number)

    if number < 1:
        number = 1

    archives = sorted(os.listdir("versions"))
    to_delete = archives[:-number]

    with lcd("versions"):
        for archive in to_delete:
            local("rm -f {}".format(archive))

    with cd("/data/web_static/releases"):
        releases = run("ls -tr").split()
        releases = [release for release in releases if "web_static_" in release]
        to_delete = releases[:-number]

        for release in to_delete:
            run("rm -rf {}".format(release))
