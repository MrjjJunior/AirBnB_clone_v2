#!/usr/bin/python3
'''
Script distributes an archive to your web servers
'''
from fabric.api import put, run, env
from os.path import exists

env.host = ['100.25.22.66', '3.90.81.154']


def do_deploy():
    '''
    Distributes an archive to web servers
    '''
    if not os.path.exists(archive_path):
        return False
    try:
        file = archive_path.split("/")[-1]
        folder = file.split(".")[0]
        put(archive_path, "/tmp/")
        run("sudo mkdir -p /data/web_static/releases/{}/".format(folder))
        run("sudo tar -xzf /tmp/{} -C /data/web_static/releases/{}/".format(file, folder))
        run("sudo rm /tmp/{}".format(file))
        run("sudo mv /data/web_static/releases/{}/web_static/* /data/web_static/releases/{}/".format(folder, folder))
        run("sudo rm -rf /data/web_static/releases/{}/web_static".format(folder))
        run("sudo rm -rf /data/web_static/current")
        run("sudo ln -s /data/web_static/releases/{}/ /data/web_static/current".format(folder_name))
        return True
    except Exception:
        return False
