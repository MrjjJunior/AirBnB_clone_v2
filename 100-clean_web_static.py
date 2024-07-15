#!/usr/bin/python3
"""
Deletes out-of-date archives
fab -f 100-clean_web_static.py do_clean:number=2
    -i ssh-key -u ubuntu > /dev/null 2>&1
"""

import os
from fabric.api import *

env.hosts = ['100.25.22.66', '3.90.81.154']


def do_clean(number=0):
    """Delete out-of-date archives.
    Args:
        number (int): The number of archives to keep.
    If number is 0, keeps only the most recent archive. If
    number is 1, keeps the two most recent archives, etc.
    """
    number = int(number)

    if number < 0:
        print("Error: Number should be a non-negative integer.")
        return

    # Local cleanup
    with lcd("versions"):
        local_archives = sorted(os.listdir("."))
        if number >= len(local_archives):
            print("Keeping all archives as requested number is greater than total available archives.")
            return

        archives_to_delete = local_archives[:-number]
        for archive in archives_to_delete:
            local("rm -f {}".format(archive))

    # Remote cleanup
    with cd("/data/web_static/releases"):
        remote_archives = run("ls -tr | grep web_static_").split()
        if number >= len(remote_archives):
            print("Keeping all archives as requested number is greater than total available archives.")
            return

        archives_to_delete = remote_archives[:-number]
        for archive in archives_to_delete:
            run("rm -rf {}".format(archive))

# Task registration
if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Clean up old archives.")
    parser.add_argument("number", type=int, help="Number of archives to keep.")
    args = parser.parse_args()

    do_clean(args.number)

