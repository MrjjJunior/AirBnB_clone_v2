# Install Nginx if it is not already installed
package { 'nginx':
  ensure => installed,
}

# Create the necessary directories
file { ['/data', '/data/web_static', '/data/web_static/releases', '/data/web_static/shared', '/data/web_static/releases/test']:
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0755',
}

# Create a fake HTML file
file { '/data/web_static/releases/test/index.html':
  ensure  => 'file',
  content => '<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0644',
}

# Create a symbolic link
file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test',
  owner  => 'ubuntu',
  group  => 'ubuntu',
  require => File['/data/web_static/releases/test'],
}

exec { 'set_permissions':
  command => 'chown -R ubuntu:ubuntu /data',
  path    => '/bin:/usr/bin',
  require => File['/data'],
}
