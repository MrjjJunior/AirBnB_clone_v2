from fabric import task
from datetime import datetime
import os

@task
def do_pack(c):
    """Generates a .tgz archive from the contents of the web_static folder."""
    # Create the versions directory if it doesn't exist
    if not os.path.exists("versions"):
        os.makedirs("versions")

    # Create the archive filename with the format web_static_<year><month><day><hour><minute><second>.tgz
    now = datetime.now()
    archive_name = "web_static_{}.tgz".format(now.strftime("%Y%m%d%H%M%S"))

    # Create the full archive path
    archive_path = "versions/{}".format(archive_name)

    # Create the archive
    result = c.local("tar -cvzf {} web_static".format(archive_path))

    # Return the archive path if the archive was correctly generated, otherwise return None
    if result.ok:
        return archive_path
    else:
        return None
