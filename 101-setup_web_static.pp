# Install Nginx if it not already installed
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure     => running,
  enable     => true,
  subscribe  => File['/etc/nginx/sites-available/default'],
}

# Allow Nginx HTTP through the firewall
exec { 'allow_nginx_http':
  command => 'ufw allow "Nginx HTTP"',
  unless  => 'ufw status | grep -q "Nginx HTTP"',
  require => Package['nginx'],
}

# Create the required directories
file { ['/data', '/data/web_static', '/data/web_static/releases', '/data/web_static/releases/test', '/data/web_static/shared']:
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0755',
  recurse => true,
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
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0644',
}

# Create a symbolic link
file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test',
  owner  => 'ubuntu',
  group  => 'ubuntu',
  require => File['/data/web_static/releases/test'],
}

# Update Nginx configuration to serve the content
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Template for Nginx default site configuration
file { '/etc/puppetlabs/code/environments/production/modules/nginx/templates/default.erb':
  ensure  => 'file',
  content => '
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location /hbnb_static/ {
        alias /data/web_static/current/;
    }
}',
  require => Package['nginx'],
}

# Ensure permissions and ownership for /data
exec { 'set_permissions':
  command => 'chown -R ubuntu:ubuntu /data',
  path    => '/bin:/usr/bin',
  require => File['/data'],
}
