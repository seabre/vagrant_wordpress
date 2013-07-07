class {'mysql':  }
class {'apache':  }

# Setup apache
apache::vhost { 'wordpress_project':
    priority        => '10',
    vhost_name      => '*',
    port            => '80',
    docroot         => '/wordpress_project/',
}

# Update Apt Repo
exec {"update-apt":
  command => "apt-get update",
  cwd     => "/",
  path    => ["/usr/bin", "/usr/local/bin", "/bin", "/usr/local/sbin", "/usr/sbin", "/sbin"],
}

# Install cURL
package {"curl":
  ensure => present,
  require => Exec["update-apt"],
}

# Install bash-completion
package {"bash-completion":
  ensure => present,
  require => Exec["update-apt"],
}

# Install openssh-server
package {"openssh-server":
  ensure => present,
  require => Exec["update-apt"],
}

# Install openssh-client
package {"openssh-client":
  ensure => present,
  require => Exec["update-apt"],
}

# Install openssh-blacklist
package {"openssh-blacklist":
  ensure => present,
  require => Exec["update-apt"],
}

# Install openssh-blacklist-extra
package {"openssh-blacklist-extra":
  ensure => present,
  require => Exec["update-apt"],
}

# Install mysql-server
class { 'mysql::server':
  config_hash => { 'root_password' => 'password' }
}

# Install php5
package {"php5":
  ensure => present,
  require => Exec["update-apt"],
}

# Install php5-gd
package {"php5-gd":
  ensure => present,
  require => Exec["update-apt"],
}

# Install php5-dev
package {"php5-dev":
  ensure => present,
  require => Exec["update-apt"],
}

# Make sure mod_php is installed
class {'apache::mod::php': }

# Install php5-mysql
class { 'mysql::php': }

# Install sysstat
package {"sysstat":
  ensure => present,
  require => Exec["update-apt"],
}

# Install subversion
package {"subversion":
  ensure => present,
  require => Exec["update-apt"],
}

# Install git
package {"git":
  ensure => present,
  require => Exec["update-apt"],
}

# Install phpmyadmin
package {"phpmyadmin":
  ensure => present,
  require => Exec["update-apt"],
}

# Install rkhunter
package {"rkhunter":
  ensure => present,
  require => Exec["update-apt"],
}

# Install logwatch
package {"logwatch":
  ensure => present,
  require => Exec["update-apt"],
}

# Install php5-curl
package {"php5-curl":
  ensure => present,
  require => Exec["update-apt"],
}

# Install tree
package {"tree":
  ensure => present,
  require => Exec["update-apt"],
}

# Create DB for project.
mysql::db { 'dda':
  user     => 'dda',
  password => 'password',
  host     => 'localhost',
  grant    => ['all'],
}
