#!/usr/bin/python
'''
script creates and distributes an archive to web servers
'''
from fabric.api import put, run, env
from os.path import exists

#configuring hosts
env.host = ['100.25.22.66', '3.90.81.154'] #[web-01, web-02]

def do_deploy():
    '''Distributes an archive to web servers
    '''
    #checking file path exist
    if not os.path.exists(archive_path):
        return False
    
    try:
        #getting file name from archive
        file = archive_path.split("/")[-1]
        #getting folder name from archive
        folder = file.split(".")[0]
        #upload archive to /tmp directory of the web server
        put(archive_path, "/tmp/")
        #creates required directories
        run("sudo mkdir -p /data/web_static/releases/{}/".format(folder))
        #uncompressing the archive
        run("sudo tar -xzf /tmp/{} -C /data/web_static/releases/{}/".format(file, folder))
        #deleting archive from web server
        run("sudo rm /tmp/{}".format(file))
        #move content to correct folder
        run("sudo mv /data/web_static/releases/{}/web_static/* /data/web_static/releases/{}/".format(folder, folder))
        #delete useless web_static folder
        run("sudo rm -rf /data/web_static/releases/{}/web_static".format(folder))
        #delete symbolic link
        run("sudo rm -rf /data/web_static/current")
        #new symboolic link
        run("sudo ln -s /data/web_static/releases/{}/ /data/web_static/current".format(folder_name))

        return True
    except:
        return False
