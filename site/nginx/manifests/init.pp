# nginx/manifests/init.pp
class nginx (
  $nginx_logsdir = $nginx::params::logsdir,
  $nginx_confdir = $nginx::params::confdir,
  $nginx_blckdir = $nginx::params::blckdir,
  $nginx_pkgname = $nginx::params::pkgname,
  $nginx_fileown = $nginx::params::fileown,
  $nginx_filegrp = $nginx::params::filegrp,
  $nginx_svcname = $nginx::params::svcname,
  $nginx_docroot = $nginx::params::docroot,
) inherits nginx::params {
  
  File {
    ensure => file,
    owner  =>  $nginx_fileown,
    group  => $nginx_filegrp,
    mode   => '0644',
  }

  package { $nginx_pkgname:
    ensure => present,
    before => [File["${nginx_blckdir}/default.conf"],File["${nginx_confdir}/nginx.conf"]],
  }
  
  file { $nginx_docroot: 
    ensure => directory,
  }
  
  file { "${nginx_docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${nginx_blckdir}/default.conf":
    content  => epp('nginx/default.conf.epp'),
  }
  
  file { "${nginx_confdir}/nginx.conf":
    content  => epp('nginx/nginx.conf.epp'),
}
    
  service { $nginx_svcname:
    ensure    => running,
    enable    => true,
    subscribe => [File["${nginx_blckdir}/default.conf"],File["${nginx_confdir}/nginx.conf"]],
  }
}
