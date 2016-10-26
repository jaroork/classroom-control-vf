class nginx {

package { 'nginx':
  ensure => present,
}

file { '/etc/nginx/nginx.conf':
  ensure => 'file',
  group => 'root',
  owner => 'root',
  mode => '0644',
  source => 'puppet:///modules/nginx/nginx.conf',
  require => Package['nginx'],
}

file { '/var/www/index.html':
  ensure => 'file',
  group => 'root',
  owner => 'root',
  mode => '0644',
  source => 'puppet:///modules/nginx/index.html',
  require => Package['nginx'],
}

file { '/etc/nginx/conf.d/default.conf':
  ensure => 'file',
  group => 'root',
  owner => 'root',
  mode => '0644',
  source => 'puppet:///modules/nginx/default.conf',
  require => Package['nginx'],
}

service { 'nginx':
  ensure => running,
  enable => true,
  subscribe => File['/etc/nginx/nginx.conf'],
}

}
