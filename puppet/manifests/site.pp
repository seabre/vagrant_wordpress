# Set path
Exec { 
  path => '/usr/bin:/usr/sbin/:/bin:/sbin:/usr/local/bin:/usr/local/sbin'
}

# Run updates
stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':}
}
class { 'apt_get_update':
  stage => preinstall
}

# Setup Apache
class { 'apache': 
  mpm_module => 'prefork'
}

apache::vhost { $project_name:
    vhost_name  => '*',
    priority    => '10',
    port        => '80',
    docroot     => '/wordpress_project/'
}

# Install mod_rewrite
apache::mod { 'rewrite': }

# Install mod_php
class { 'apache::mod::php': }

# Install cURL
package { "curl":
  ensure => present
}

# Install php5
package { "php5":
  ensure => present
}

# Install php5-gd
package { "php5-gd":
  ensure => present
}

# Install php5-dev
package { "php5-dev":
  ensure => present
}

# Install php5-curl
package { "php5-curl":
  ensure => present
}

# Install phpmyadmin
package { "phpmyadmin":
  ensure => present
}

# Install php5-mysql
package { "php5-mysql":
  ensure => present
}

# Setup MySQL
class { 'mysql::server':
  root_password => 'password' }

# Create database for project
mysql::db { $project_name:
  user     => $project_name,
  password => 'password',
  host     => 'localhost',
  grant    => ['all']
}

# Install WordPress
class { 'wordpress':
  wp_owner        => 'www-data',
  wp_group        => 'www-data',
  install_dir     => '/wordpress_project/',
  version         => 'latest',
  create_db       => false,
  create_db_user  => false,
  db_name         => $project_name,
  db_user         => $project_name,
  db_password     => 'password'
}