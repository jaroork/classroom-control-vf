class nginx {
  
  case $::osfamily {
    'RedHat': {
      $docroot = '/var/www'
      $logdir = '/var/log/nginx'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
    }
    'windows': {
      $docroot = 'C:/ProgramData/nginx/html'
      $logdir = 'C:/ProgramData/nginx/logs'
      $confdir = 'C:/ProgramData/nginx/'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
    }
  }
  
  $user = $::osfamily ? {
    'Redhat' => 'nginx'
    'Debian' => 'www-data'
    'windows' => 'nobody'
  }
  
  File {
    owner => 'root',
    group => 'root',
    mode => '0664',
    ensure => 'file',
    require => Package['nginx'],
  }
  
  package { 'nginx':
    ensure => present,
    before => [File["${blockdir}/default.conf"],File["${confdir}/nginx.conf"]],
  }

  file { "${confdir}/nginx.conf":
    content  => epp('nginx/nginx.conf.epp'),
  }

  file { "${docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }

  file { "${blockdir}/default.conf":
    content  => epp('nginx/default.conf.epp'),
  }
  
  file { $docroot:
    ensure => 'directory',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [File["${blockdir}/default.conf"],File["${confdir}/nginx.conf"]],
  }
}
