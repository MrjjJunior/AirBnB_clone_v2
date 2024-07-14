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

exec { 'set_permissions':
  command => 'chown -R ubuntu:ubuntu /data',
  path    => '/bin:/usr/bin',
  require => File['/data'],
}
