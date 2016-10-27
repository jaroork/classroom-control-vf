class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode => '0664',
    ensure => 'file',
    require => Package['nginx'],
  }
  
  package { 'nginx':
    ensure => present,
  }

  file { '/etc/nginx/nginx.conf':
    source => 'puppet:///modules/nginx/nginx.conf',
  }

  file { '/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
  }

  file { '/etc/nginx/conf.d/default.conf':
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  file { '/var/www':
    ensure => 'directory',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [File['/etc/nginx/nginx.conf'],File['/etc/nginx/conf.d/default.conf']],
  }
}
