Exec { path => '/usr/bin:/usr/sbin/:/bin:/sbin:/usr/local/bin:/usr/local/sbin' }

# Run updates.
stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':}
}
class { 'apt_get_update':
  stage => preinstall
}

class {'mysql': }

# Install mysql-server
class { 'mysql::server':
  config_hash => { 'root_password' => 'password' }
}

#class { 'apache':
#  default_vhost => false,
#}

# Setup apache
apache::vhost { 'wordpress':
    vhost_name => '*',
    priority        => '10',
    port            => '80',
    docroot         => '/wordpress_project/',
    configure_firewall => false,
    override => 'All'
}

# Install cURL
package {"curl":
  ensure => present,
}

# Install php5
package {"php5":
  ensure => present,
}

# Install php5-gd
package {"php5-gd":
  ensure => present,
}

# Install php5-dev
package {"php5-dev":
  ensure => present,
}

# Make sure mod_php is installed
class {'apache::mod::php': }

# Make sure mod_rewrite is installed
apache::mod { 'rewrite': }

# Install php5-mysql
class { 'mysql::php': }

# Install phpmyadmin
package {"phpmyadmin":
  ensure => present,
}

# Install php5-curl
package {"php5-curl":
  ensure => present,
}

# Create DB for project.
mysql::db { '<%= projectName %>':
  user     => '<%= projectName %>',
  password => '<%= projectPassword %>',
  host     => 'localhost',
  grant    => ['all'],
}

# Ensure uploads folder is created.
file { "/wordpress_project/wp-content/uploads":
  owner => "www-data",
  group => "www-data",
  mode => "755",
  ensure => "directory"
}
